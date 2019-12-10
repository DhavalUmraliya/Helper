//
//  TapGestureExtensions.swift
//  CookerApp
//
//  Created by Admin on 28/12/17.
//  Copyright © 2017 EL. All rights reserved.
//

import UIKit
class ClassTapGesture: UITapGestureRecognizer
{
    let identifier: String
    
    private override init(target: Any?, action: Selector?) {
        self.identifier = ""
        super.init(target: target, action: action)
    }
    
    init(target: Any?, action: Selector?, identifier: String) {
        self.identifier = identifier
        super.init(target: target, action: action)
    }
    
    static func == (left: ClassTapGesture, right: ClassTapGesture) -> Bool {
        return left.identifier == right.identifier
    }
}

extension UIView
{
    private var disableKeybordWhenTappedGestureRecognizerIdentifier:String {
        return "disableKeybordWhenTapped"
    }
    
    private var disableKeybordWhenTappedGestureRecognizer: ClassTapGesture? {
        
        let hideKeyboardGesture = ClassTapGesture(target: self, action: #selector(UIView.hideKeyboardShown), identifier: disableKeybordWhenTappedGestureRecognizerIdentifier)
        
        if let gestureRecognizers = self.gestureRecognizers {
            for gestureRecognizer in gestureRecognizers {
                if let tapGestureRecognizer = gestureRecognizer as? ClassTapGesture, tapGestureRecognizer == hideKeyboardGesture, tapGestureRecognizer == hideKeyboardGesture {
                    return tapGestureRecognizer
                }
            }
        }
        return nil
    }
    
    @objc private func hideKeyboardShown() {
        endEditing(true)
    }
    
    var disableKeybordWhenTapped: Bool {
        
        set {
            let hideKeyboardGesture = ClassTapGesture(target: self, action: #selector(UIView.hideKeyboardShown), identifier: disableKeybordWhenTappedGestureRecognizerIdentifier)
            
            if let disableKeybordWhenTappedGestureRecognizer = self.disableKeybordWhenTappedGestureRecognizer {
                removeGestureRecognizer(disableKeybordWhenTappedGestureRecognizer)
                if gestureRecognizers?.count == 0 {
                    gestureRecognizers = nil
                }
            }
            
            if newValue {
                addGestureRecognizer(hideKeyboardGesture)
            }
        }
        
        get {
            return disableKeybordWhenTappedGestureRecognizer == nil ? false : true
        }
    }
}
extension UITableView
{
    private var disableKeybordWhenTappedGestureRecognizerIdentifier:String {
        return "disableKeybordWhenTapped"
    }
    
    private var disableKeybordWhenTappedGestureRecognizer: ClassTapGesture? {
        
        let hideKeyboardGesture = ClassTapGesture(target: self, action: #selector(UITableView.hideKeyboard1), identifier: disableKeybordWhenTappedGestureRecognizerIdentifier)
        
        if let gestureRecognizers = self.gestureRecognizers {
            for gestureRecognizer in gestureRecognizers {
                if let tapGestureRecognizer = gestureRecognizer as? ClassTapGesture, tapGestureRecognizer == hideKeyboardGesture, tapGestureRecognizer == hideKeyboardGesture {
                    return tapGestureRecognizer
                }
            }
        }
        return nil
    }
    
    @objc private func hideKeyboard1() {
        endEditing(true)
    }
    
    var disableKeybordWhenTappedTbl: Bool {
        
        set {
            let hideKeyboardGesture = ClassTapGesture(target: self, action: #selector(UITableView.hideKeyboard1), identifier: disableKeybordWhenTappedGestureRecognizerIdentifier)
            
            if let disableKeybordWhenTappedGestureRecognizer = self.disableKeybordWhenTappedGestureRecognizer {
                removeGestureRecognizer(disableKeybordWhenTappedGestureRecognizer)
                if gestureRecognizers?.count == 0 {
                    gestureRecognizers = nil
                }
            }
            
            if newValue {
                addGestureRecognizer(hideKeyboardGesture)
            }
        }
        
        get {
            return disableKeybordWhenTappedGestureRecognizer == nil ? false : true
        }
    }
}

