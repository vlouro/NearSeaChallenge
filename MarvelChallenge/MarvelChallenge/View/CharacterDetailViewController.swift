//
//  CharacterDetailViewController.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var character : Character? = nil
    let cellIdentifier = "ComicsCollectionViewCell"
    let tableCellIdentifier = "DetailContentTableViewCell"
    var tableViewHeight: CGFloat = 0
    
    lazy var viewModel = {
        CharacterDetailViewModel()
    }()
    
    let closeButton : UIButton = {
        let btn = UIButton()
        if let image = UIImage(named: "Combined Shape") {
            btn.setImage(image, for: .normal)
        }
        btn.isUserInteractionEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let shareButton : UIButton = {
        let btn = UIButton()
        if let image = UIImage(named: "share") {
            btn.setImage(image, for: .normal)
        }
        btn.isUserInteractionEnabled = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let scrollView : UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        return scrView
    }()
    
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameContentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.addBlur()
        v.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let characterNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = ThemeColors.customGrey07Color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overViewTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = ThemeColors.customGrey07Color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overViewDescriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = ThemeColors.customGrey07Color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let comicsTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = ThemeColors.customGrey07Color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let comicsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.alwaysBounceHorizontal = true
        collectionview.showsVerticalScrollIndicator = false
        collectionview.showsHorizontalScrollIndicator = false
        collectionview.backgroundColor = .clear
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        return collectionview
    }()
    
    let contentTableView: UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .clear
        tableview.bounces = false
        tableview.isScrollEnabled = false
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = ThemeColors.aboutBackgroundColor
        self.setupScrollView()
        self.setupUI()
        self.setupData()
        self.initViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func initViewModel() {
        viewModel.getComics(characterId: character?.id ?? 0, completionHandler: { shouldReload in
            if shouldReload {
                DispatchQueue.main.async {
                    self.comicsCollectionView.reloadData()
                }
            }
        })
        
        viewModel.downloadDetails(characterId: character?.id ?? 0) { shouldReload in
            if shouldReload {
                DispatchQueue.main.async {
                    self.contentTableView.reloadData()
                    self.updateTableHeightConstraint()
                }
            }
        }
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.delaysContentTouches = false
        scrollView.isExclusiveTouch = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    func setupUI() {
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(closeButton)
        contentView.addSubview(nameContentView)
        nameContentView.addSubview(shareButton)
        nameContentView.addSubview(characterNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(overViewTitleLabel)
        contentView.addSubview(overViewDescriptionLabel)
        contentView.addSubview(comicsTitleLabel)
        contentView.addSubview(comicsCollectionView)
        contentView.addSubview(contentTableView)
        
        self.comicsCollectionView.delegate = self
        self.comicsCollectionView.dataSource = self
        self.comicsCollectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        self.contentTableView.delegate = self
        self.contentTableView.dataSource = self
        self.contentTableView.register(DetailContentTableViewCell.self, forCellReuseIdentifier: tableCellIdentifier)
        
        closeButton.addTarget(self, action: #selector(dismissView), for: .allTouchEvents)
        
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 354),
            
            closeButton.widthAnchor.constraint(equalToConstant: 44),
            closeButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18),
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            
            nameContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameContentView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -40),
            nameContentView.heightAnchor.constraint(equalToConstant: 60),
            
            shareButton.widthAnchor.constraint(equalToConstant: 44),
            shareButton.centerYAnchor.constraint(equalTo: nameContentView.centerYAnchor),
            shareButton.rightAnchor.constraint(equalTo: nameContentView.rightAnchor, constant: -18),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: nameContentView.leadingAnchor, constant: 18),
            characterNameLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: 18),
            characterNameLabel.bottomAnchor.constraint(equalTo: nameContentView.bottomAnchor),
            characterNameLabel.topAnchor.constraint(equalTo: nameContentView.topAnchor),
            
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameContentView.bottomAnchor, constant: 18),
            
            overViewTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            overViewTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            overViewTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 36),
            
            overViewDescriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            overViewDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            overViewDescriptionLabel.topAnchor.constraint(equalTo: overViewTitleLabel.bottomAnchor, constant: 18),
            
            comicsTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            comicsTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            comicsTitleLabel.topAnchor.constraint(equalTo: overViewDescriptionLabel.bottomAnchor, constant: 36),
            
            comicsCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            comicsCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            comicsCollectionView.topAnchor.constraint(equalTo: comicsTitleLabel.bottomAnchor, constant: 18),
            comicsCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
        ])
        
        
    }
    
    func setupData() {
        
        if let characterDetail = self.character {
            let imageUrl  = characterDetail.thumbnail.path+"."+characterDetail.thumbnail.thumbnailExtension
            characterImageView.imageFromServerURL(urlString: imageUrl, PlaceHolderImage: UIImage())
            
            characterNameLabel.setLabelAttributedText(name: characterDetail.name , fontSize: 27, fontWeight: .semibold, lineSpacing: 1.1851851851851851)
            
            
            descriptionLabel.setLabelAttributedText(name: characterDetail.resultDescription.count > 0 ? characterDetail.resultDescription : "No Description", fontSize: 18, fontWeight: .medium, lineSpacing: 1.5555555555555556)
            
            overViewTitleLabel.setLabelAttributedText(name:"Overview", fontSize: 27, fontWeight: .semibold, lineSpacing: 1.1851851851851851)
            
            overViewDescriptionLabel.setLabelAttributedText(name: characterDetail.resultDescription.count > 0 ? characterDetail.resultDescription : "No Overview", fontSize: 16, fontWeight: .regular, lineSpacing: 1.75)
            
            comicsTitleLabel.setLabelAttributedText(name: "Comics", fontSize: 27, fontWeight: .semibold, lineSpacing: 1.1851851851851851)
        }
        
    }
    
    func updateTableHeightConstraint(){
        
        for detailContent in viewModel.detailsContent{
            tableViewHeight += 60
            for _ in detailContent.items {
                tableViewHeight += 108
            }
        }
        
        NSLayoutConstraint.activate([
            contentTableView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            contentTableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            contentTableView.topAnchor.constraint(equalTo: comicsCollectionView.bottomAnchor, constant: 0),
            contentTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentTableView.heightAnchor.constraint(equalToConstant: tableViewHeight)
        ])
        
    }
    
    @objc func dismissView(){
        self.dismiss(animated: true)
    }
    
    
}


extension CharacterDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.comicsCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = comicsCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! ComicsCollectionViewCell
        cell.cellViewModel = self.viewModel.comicsCellViewModels[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 264)
    }
    
    
    
}


extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.detailsContent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.detailsContent[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contentTableView.dequeueReusableCell(withIdentifier: self.tableCellIdentifier, for: indexPath) as! DetailContentTableViewCell
        cell.cellViewModel = self.viewModel.detailsContent[indexPath.section].items[indexPath.row] as? DetailContentCellViewModel
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 34))
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setLabelAttributedText(name: self.viewModel.detailsContent[section].name, fontSize: 27, fontWeight: .semibold, lineSpacing: 1.1851851851851851)
        label.textColor = ThemeColors.customGrey07Color
        headerView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 18),
            label.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -18),
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    
}
