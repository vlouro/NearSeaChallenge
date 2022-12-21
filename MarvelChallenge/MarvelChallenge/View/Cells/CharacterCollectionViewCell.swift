//
//  CharacterCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 19/12/2022.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameContentView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 10
        v.clipsToBounds = true
        v.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
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
    
    var cellViewModel: CharacterCellViewModel? {
        didSet {
            characterNameLabel.setLabelAttributedText(name: cellViewModel?.name ?? "", fontSize: 27, fontWeight: .semibold, lineSpacing: 1.1851851851851851)
            if let imgUrl = cellViewModel?.imageUrl {
                characterImageView.imageFromServerURL(urlString: imgUrl, PlaceHolderImage: UIImage())
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
            contentView.addSubview(characterImageView)
            contentView.addSubview(nameContentView)
            nameContentView.addBlur()
            nameContentView.addSubview(characterNameLabel)
            
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            characterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            characterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18),
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            nameContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18),
            nameContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameContentView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: nameContentView.leadingAnchor, constant: 18),
            characterNameLabel.trailingAnchor.constraint(equalTo: nameContentView.trailingAnchor),
            characterNameLabel.bottomAnchor.constraint(equalTo: nameContentView.bottomAnchor),
            characterNameLabel.topAnchor.constraint(equalTo: nameContentView.topAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterNameLabel.attributedText = nil
        characterImageView.image = nil
    }
    
    
}
