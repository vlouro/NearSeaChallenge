//
//  UILabel+Extension.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 20/12/2022.
//

import Foundation
import UIKit

extension UILabel {
    
    func setLabelAttributedText(name: String, fontSize: CGFloat, fontWeight: UIFont.Weight, lineSpacing: CGFloat) {
        let characterNameString = NSMutableAttributedString(
          string: name,
          attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
          ]
        )
        let textRange = NSRange(location: 0, length: characterNameString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        characterNameString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: textRange)
        characterNameString.addAttribute(NSAttributedString.Key.kern, value: 0, range: textRange)
        self.attributedText = characterNameString
    }
    
}
