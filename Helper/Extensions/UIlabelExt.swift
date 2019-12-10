//
//  UIlabelExt.swift
//  Mixie
//
//  Created by WOS1 on 16/06/18.
//  Copyright © 2018 wos. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    @objc public var substituteFontName : String {
        get {
            return self.font.fontName;
        }
        set {
            let fontNameToTest = self.font.fontName.lowercased();
            var fontName = newValue;
            if fontNameToTest.range(of: "Bold") != nil {
                fontName += "-Bold";
            } else if fontNameToTest.range(of: "Medium") != nil {
                fontName += "-Medium";
            } else if fontNameToTest.range(of: "Light") != nil {
                fontName += "-Light";
            } else if fontNameToTest.range(of: "Regular") != nil {
                fontName += "-Regular";
            }
            self.font = UIFont(name: fontName, size: self.font.pointSize)
        }
    }
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText
        
        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedStringKey.font: self.font])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedStringKey.font: moreTextFont, NSAttributedStringKey.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }
    
    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes: [AnyHashable: Any] = [NSAttributedStringKey.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedStringKey : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)
        
        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedStringKey : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
}

//Uses

//let readmoreFont = UIFont(name: "Helvetica-Oblique", size: 11.0)
//let readmoreFontColor = UIColor.blue
//DispatchQueue.main.async {
//    self.yourLabel.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
//}

