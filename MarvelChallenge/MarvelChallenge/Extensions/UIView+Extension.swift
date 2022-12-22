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
        blurBackground.backgroundColor = ThemeColors.cellBlurColor
        addSubview(blurBackground)
        blurBackground.translatesAutoresizingMaskIntoConstraints = false
        blurBackground.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurBackground.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurBackground.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurBackground.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return blurBackground
    }
    
    func addGradient(colors: [UIColor] = [UIColor(red: 0.86, green: 0, blue: 0.64, alpha: 1), UIColor(red: 0.91, green: 0, blue: 0, alpha: 1)], locations: [NSNumber] = [0, 1], startPoint: CGPoint = CGPoint(x: 1.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 0.0, y: 1.0), type: CAGradientLayerType = .axial){
        
        let gradient = CAGradientLayer()
        
        gradient.frame.size = self.frame.size
        gradient.frame.origin = CGPoint(x: 0.0, y: 0.0)
        
        // Iterates through the colors array and casts the individual elements to cgColor
        // Alternatively, one could use a CGColor Array in the first place or do this cast in a for-loop
        gradient.colors = colors.map{ $0.cgColor }
        
        gradient.locations = locations
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        // Insert the new layer at the bottom-most position
        // This way we won't cover any other elements
        self.layer.insertSublayer(gradient, at: 0)
    }
}
