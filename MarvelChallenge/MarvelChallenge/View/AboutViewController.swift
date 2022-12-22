//
//  AboutViewController.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 18/12/2022.
//

import UIKit

class AboutViewController: UIViewController {
    
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
    
    
    //UI ELEMENTS
    
    let aboutLabel : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 36, weight: .semibold)
        lbl.font.withSize(36)
        lbl.text = "About this app"
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subTitle1  : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        lbl.text = "We can be heroes"
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subText1  : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = ThemeColors.customGrey07Color
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        lbl.textAlignment = .left
        let textContent = "Charismatic, agile, strong, united, passionate and with a lot of wisdom, we are all Heroes in our own way."
        let textString = NSMutableAttributedString(
            string: textContent,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .medium)
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5555555555555556
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 0.27, range: textRange)
        lbl.attributedText = textString
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subTitle2  : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = ThemeColors.customGrey07Color
        lbl.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        lbl.text = "Overview"
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let subText2 : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = ThemeColors.customGrey07Color
        let textContent = "In fact, what makes us heroes are not supernatural forces, but the small gestures and attitudes that help to improve the daily lives of all of us and those around us. Heroes from December 8th to 11th at Parque das Nações – Lisbon."
        let textString = NSMutableAttributedString(
            string: textContent,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.75
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 0.24, range: textRange)
        lbl.attributedText = textString
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subTitle3  : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textColor = ThemeColors.customGrey07Color
        lbl.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        lbl.text = "Top selling items"
        lbl.textAlignment = .left
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let subText3 : UILabel = {
        let lbl = UILabel()
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.textColor = ThemeColors.customGrey07Color
        let textContent = "market.epopculture.com"
        let textString = NSMutableAttributedString(
            string: textContent,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)
            ]
        )
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.5
        textString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        textString.addAttribute(NSAttributedString.Key.kern, value: 0.24, range: textRange)
        lbl.attributedText = textString
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeColors.aboutBackgroundColor
        self.setupScrollView()
        self.setupUI()
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
    }
    
    func setupUI() {
        contentView.addSubview(aboutLabel)
        contentView.addSubview(subTitle1)
        contentView.addSubview(subText1)
        contentView.addSubview(subTitle2)
        contentView.addSubview(subText2)
        contentView.addSubview(subTitle3)
        contentView.addSubview(subText3)
        
        aboutLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18).isActive = true
        aboutLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        aboutLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        subTitle1.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 36).isActive = true
        subTitle1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        subTitle1.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        subText1.topAnchor.constraint(equalTo: subTitle1.bottomAnchor, constant: 32).isActive = true
        subText1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        subText1.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        subTitle2.topAnchor.constraint(equalTo: subText1.bottomAnchor, constant: 36).isActive = true
        subTitle2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        subTitle2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        subText2.topAnchor.constraint(equalTo: subTitle2.bottomAnchor, constant: 18).isActive = true
        subText2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        subText2.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        subTitle3.topAnchor.constraint(equalTo: subText2.bottomAnchor, constant: 36).isActive = true
        subTitle3.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        subTitle3.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        
        subText3.topAnchor.constraint(equalTo: subTitle3.bottomAnchor, constant: 8).isActive = true
        subText3.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 18).isActive = true
        subText3.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -18).isActive = true
        subText3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        
    }

}
