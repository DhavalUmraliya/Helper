//
//  ProgressView.swift
//  AQI
//
//  Created by WOS1 on 03/10/18.
//  Copyright © 2018 wos. All rights reserved.
//

import Foundation
import UIKit

extension UIProgressView {
    
    @IBInspectable var barHeight : CGFloat {
        get {
            return transform.d * 2.0
        }
        set {
            // 2.0 Refers to the default height of 2
            let heightScale = newValue / 2.0
            let c = center
            transform = CGAffineTransform(scaleX: 1.0, y: heightScale)
            center = c
        }
    }
}

extension UIView {
    
    // OUTPUT 1
//    func dropShadow(scale: Bool = true) {
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.5
//        layer.shadowOffset = CGSize(width: -1, height: 1)
//        layer.shadowRadius = 1
//
//        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
//    }
//

    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
