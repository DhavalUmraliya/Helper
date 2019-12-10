//
//  UIButtonEx.swift
//  Mixie
//
//  Created by WOS1 on 13/06/18.
//  Copyright © 2018 wos. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    
    func setBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: frame.size.width, height: width)
        self.layer.addSublayer(border)
     }
}
