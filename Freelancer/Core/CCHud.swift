//
//  CCHud.swift
//  Plus4U
//
//  Created by Cyril on 10/03/17.
//  Copyright © 2017 cyril. All rights reserved.
//

import Foundation
import SVProgressHUD


class CCHud {
    
    
    fileprivate static func setUp() {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultAnimationType(.flat)
    }
    
    static func isPresenting() -> Bool {
        return SVProgressHUD.isVisible()
    }
    
    fileprivate static func setupTimeInterval(delay: Double) -> DispatchTime {
        self.setUp()
        SVProgressHUD.setMaximumDismissTimeInterval(delay)
        return DispatchTime.now() + delay
    }
    
    static func show() {
        self.setUp()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.dispatch(action: { SVProgressHUD.show() })
    }
    
    static func show(_ title: String?, delay: Double = 2.0, completion:@escaping(_ completed:Bool) -> Void = { _ in }) {
        let dispatchTime = self.setupTimeInterval(delay: delay)
        
        self.dispatch(action: { SVProgressHUD.show() })
        self.dispatchFinished(dispatchTime: dispatchTime, completion: completion)
    }
    
    static func hide() {
        SVProgressHUD.dismiss()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    static func hide(completion:@escaping(_ completed:Bool)->Void = { _ in }) {
        _ = self.setupTimeInterval(delay: 2.0)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        SVProgressHUD.dismiss()
        self.dispatchFinished(dispatchTime: DispatchTime.now()) { (completed) in
            completion(true)
        }
    }
    
    
    static func showWith(title: String) {
        _ = self.setupTimeInterval(delay: 2.0)
        self.dispatch(action: { SVProgressHUD.show(withStatus: title) })
    }
    
    static func showError(_ title: String = "", delay: Double = 2.0, completion:@escaping(_ completed:Bool?) -> Void = {_ in} ) {
        let dispatchTime = self.setupTimeInterval(delay: delay)
        self.dispatch(action: { SVProgressHUD.showError(withStatus: title) })
        self.dispatchFinished(dispatchTime: dispatchTime, completion: completion)
    }
    
    static func showSuccess(_ title: String = "", delay: Double = 2.0, withKeyboardDelay: Bool = false, completion:@escaping(_ completed:Bool) -> Void = { _ in }) {
        let dispatchTime = self.setupTimeInterval(delay: delay)
        
        self.dispatch(action: { SVProgressHUD.showSuccess(withStatus: title) })
        self.dispatchFinished(dispatchTime: dispatchTime, completion: completion)
    }

    fileprivate static func dispatch(action:@escaping () -> Void) {
        if KeyboardNotificationMananger.main().isKeyboardVisible {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                action()
            }
        } else {
            action()
        }
    }

    fileprivate static func dispatchFinished(dispatchTime: DispatchTime, completion:@escaping(_ completed:Bool) -> Void ) {
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            completion(true)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
