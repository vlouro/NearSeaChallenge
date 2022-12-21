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
    
    lazy var viewModel = {
        CharacterDetailViewModel()
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
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overViewTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let overViewDescriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let comicsTitleLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
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
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func setupUI() {
        
        
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameContentView)
        nameContentView.addSubview(characterNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(overViewTitleLabel)
        contentView.addSubview(overViewDescriptionLabel)
        contentView.addSubview(comicsTitleLabel)
        contentView.addSubview(comicsCollectionView)
        
        self.comicsCollectionView.delegate = self
        self.comicsCollectionView.dataSource = self
        self.comicsCollectionView.register(ComicsCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            characterImageView.heightAnchor.constraint(equalToConstant: 354),
            
            nameContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            nameContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameContentView.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: -40),
            nameContentView.heightAnchor.constraint(equalToConstant: 60),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: nameContentView.leadingAnchor, constant: 18),
            characterNameLabel.trailingAnchor.constraint(equalTo: nameContentView.trailingAnchor),
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
            comicsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
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
