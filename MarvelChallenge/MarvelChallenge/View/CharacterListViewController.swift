//
//  CharacterListViewController.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import UIKit

class CharacterListViewController: UIViewController, UISearchBarDelegate {
    
    let cellIdentifier = "CharacterCollectionViewCell"
    
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
        
        var image = UIImage(named: "MarvelLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: nil)
        self.navigationItem.titleView = self.navigationController?.titleMultiLine(topText: "Avengers,", bottomText: "Assemble!")
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
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            searchBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        searchBar.textColor = .white
        searchBar.setMagnifyingGlassColorTo(color: .white)
        searchBar.setPlaceholderTextColorTo(color: .white)
        searchBar.setClearButtonColorTo(color: .white)
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

    
}

extension CharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = characterCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! CharacterCollectionViewCell
        cell.cellViewModel = self.viewModel.characterCellViewModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characteDetail = CharacterDetailViewController()
        characteDetail.character = self.viewModel.character[indexPath.row]
        self.navigationController?.pushViewController(characteDetail, animated: false)
    }
    
}


