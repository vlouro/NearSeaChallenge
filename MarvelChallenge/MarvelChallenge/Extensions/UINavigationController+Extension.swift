//
//  UINavigationController+Extension.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 19/12/2022.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func titleMultiLine(topText: String, bottomText: String) -> UILabel {
  
        let titleParameters = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let subtitleParameters =  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let title:NSMutableAttributedString = NSMutableAttributedString(string: topText, attributes: titleParameters)
        let subtitle:NSAttributedString = NSAttributedString(string: bottomText, attributes: subtitleParameters)
        
        title.append(NSAttributedString(string: "\n"))
        title.append(subtitle)
        
        let size = title.size()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        titleLabel.attributedText = title
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        return titleLabel
    }
    
}
