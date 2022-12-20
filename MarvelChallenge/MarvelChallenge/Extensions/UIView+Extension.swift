//
//  UIView+Extension.swift
//  MarvelChallenge
//
//  Created by Valter Louro on 19/12/2022.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    public func addBlur(style: UIBlurEffect.Style = .dark) -> UIVisualEffectView {
           let blurEffect = UIBlurEffect(style: style)
           let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.backgroundColor = UIColor(red: 100/255, green: 21/255, blue: 169/255, alpha: 0.5)
           addSubview(blurBackground)
           blurBackground.translatesAutoresizingMaskIntoConstraints = false
           blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
           blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
           blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
           blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
           return blurBackground
    }
}

