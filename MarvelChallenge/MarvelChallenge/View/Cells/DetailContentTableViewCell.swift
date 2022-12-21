//
//  DetailContentTableViewCell.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 21/12/2022.
//

import UIKit

class DetailContentTableViewCell: UITableViewCell {

    private let detailImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.textColor = .white
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var cellViewModel: DetailContentCellViewModel? {
        didSet {
            nameLabel.setLabelAttributedText(name: cellViewModel?.name ?? "", fontSize: 18, fontWeight: .bold, lineSpacing: 1.3333333333333333)
            descriptionLabel.setLabelAttributedText(name: cellViewModel?.description ?? "", fontSize: 16, fontWeight: .regular, lineSpacing: 1.5)
            if let imgUrl = cellViewModel?.imageUrl, !imgUrl.isEmpty {
                detailImageView.imageFromServerURL(urlString: imgUrl, PlaceHolderImage: UIImage(named: "missing_comic") ?? UIImage())
            } else {
                detailImageView.image = UIImage(named: "missing_comic")
            }
            
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
            contentView.addSubview(detailImageView)
            contentView.addSubview(nameLabel)
            contentView.addSubview(descriptionLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            detailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18),
            detailImageView.widthAnchor.constraint(equalToConstant: 52),
            detailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: 78),
       
            nameLabel.leftAnchor.constraint(equalTo: detailImageView.rightAnchor, constant: 9),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            
            descriptionLabel.leftAnchor.constraint(equalTo: detailImageView.rightAnchor, constant: 9),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.attributedText = nil
        nameLabel.attributedText = nil
        detailImageView.image = nil
    }

}
