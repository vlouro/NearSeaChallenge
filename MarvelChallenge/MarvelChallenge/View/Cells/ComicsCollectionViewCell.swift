//
//  ComicsCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {
    
    let comicImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let comicNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.textColor = ThemeColors.customGrey07Color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellViewModel: ComicsCellViewModel? {
        didSet {
            comicNameLabel.setLabelAttributedText(name: cellViewModel?.name ?? "", fontSize: 16, fontWeight: .regular, lineSpacing: 1.5)
            if let imgUrl = cellViewModel?.imageUrl {
                comicImageView.imageFromServerURL(urlString: imgUrl, PlaceHolderImage: UIImage(named: "missing_comic") ?? UIImage())
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(comicImageView)
        contentView.addSubview(comicNameLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            comicImageView.widthAnchor.constraint(equalToConstant: 150),
            comicImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            comicImageView.heightAnchor.constraint(equalToConstant: 226),
            
            comicNameLabel.topAnchor.constraint(equalTo: comicImageView.bottomAnchor),
            comicNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            comicNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            comicNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
            
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        comicNameLabel.attributedText = nil
        comicImageView.image = nil
    }
}
