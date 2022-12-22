//
//  CharacterListViewController.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import UIKit

class CharacterListViewController: UIViewController {
    
    let cellIdentifier = "CharacterCollectionViewCell"
    var isRequesting = false
    var isSearchEmpty = true
    var searchedText = ""
    
    private lazy var searchBar: UISearchBar = {
        let sc = UISearchBar()
        sc.delegate = self
        sc.backgroundColor = ThemeColors.aboutBackgroundColor
        sc.tintColor = .white
        sc.barTintColor = ThemeColors.aboutBackgroundColor
        sc.placeholder = "Search"
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    lazy var viewModel = {
        CharacterViewModel()
    }()
    
    let characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceVertical = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = .clear
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeColors.aboutBackgroundColor
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        var image = UIImage(named: "MarvelLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: nil)
        if let customView = self.navigationController?.titleMultiLine(topText: "Avengers,", bottomText: "Assemble!") {
            let barButton =  UIBarButtonItem(customView: customView)
            self.navigationItem.leftBarButtonItem = barButton
        }
        
        setupSearchBar()
        setupViews()
        initViewModel()
    }
    
    func setupViews() {
        self.characterCollectionView.delegate = self
        self.characterCollectionView.dataSource = self
        self.characterCollectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.view.addSubview(characterCollectionView)
        
        NSLayoutConstraint.activate([
            characterCollectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            characterCollectionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            characterCollectionView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            characterCollectionView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    func setupSearchBar() {
        self.view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        
        searchBar.delegate = self
        
    }
    
    func initViewModel() {
        viewModel.getCharacters(nextPage: 0) { shouldReload in
            if shouldReload {
                DispatchQueue.main.async {
                    self.characterCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchBar.textColor = .white
        searchBar.setMagnifyingGlassColorTo(color: .white)
        searchBar.setPlaceholderTextColorTo(color: .white)
        searchBar.setClearButtonColorTo(color: .white)
        searchBar.setPlaceholderTextColorTo(color: .white)
    }
    
    
}

extension CharacterListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchedText = searchText
        self.isRequesting = true
        if isRequesting {
            viewModel.nextPageForSearch = 0
            viewModel.characterSearchCellViewModels.removeAll()
            viewModel.characterSearch.removeAll()
            viewModel.getCharacterBySearching(stringToSearch: searchText) { shouldReload in
                if shouldReload {
                    DispatchQueue.main.async {
                        self.characterCollectionView.reloadData()
                    }
                    self.isSearchEmpty = false
                    self.isRequesting = false
                }
            }
        }
        
        if searchText.isEmpty {
            isSearchEmpty = true
            viewModel.nextPageForSearch = 0
            viewModel.characterSearchCellViewModels.removeAll()
            viewModel.characterSearch.removeAll()
            DispatchQueue.main.async {
                self.characterCollectionView.reloadData()
            }
        }
    }
    
}

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchEmpty {
            return viewModel.characterCellViewModels.count
        } else {
            return viewModel.characterSearchCellViewModels.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        if isSearchEmpty {
            cell.cellViewModel = self.viewModel.characterCellViewModels[indexPath.row]
        } else {
            cell.cellViewModel = self.viewModel.characterSearchCellViewModels[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characteDetail = CharacterDetailViewController()
        if isSearchEmpty {
            characteDetail.character = self.viewModel.character[indexPath.row]
        } else {
            characteDetail.character = self.viewModel.characterSearch[indexPath.row]
        }
        
        characteDetail.modalPresentationStyle = .fullScreen
        self.navigationController?.present(characteDetail, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isSearchEmpty {
            if indexPath.row == viewModel.character.count - 10 {
                viewModel.getMoreCharacters { shouldReload in
                    DispatchQueue.main.async {
                        self.characterCollectionView.reloadData()
                    }
                }
            }
        } else {
            if indexPath.row == viewModel.characterSearch.count - 10 {
                viewModel.getCharacterBySearching(stringToSearch: searchedText) { shouldReload in
                    DispatchQueue.main.async {
                        self.characterCollectionView.reloadData()
                    }
                }
            }
        }
        
    }
    
}
