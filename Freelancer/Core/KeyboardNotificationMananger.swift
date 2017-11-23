//
//  KeyboardNotificationMananger.swift
//  Plus4U
//
//  Created by Cyril on 11/03/17.
//  Copyright © 2017 cyril. All rights reserved.
//

import Foundation

class KeyboardNotificationMananger {
    
    var isKeyboardVisible: Bool = {
        return false
    }()
    
    static func main() -> KeyboardNotificationMananger {
        let kbnm = KeyboardNotificationMananger()
        return kbnm
    }
    
    init() {
        /// Registering notification
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow),name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide),name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    @objc func keyboardDidShow() {
        isKeyboardVisible = true
    }
    
    @objc func keyboardDidHide() {
        isKeyboardVisible = false
    }
    
}
