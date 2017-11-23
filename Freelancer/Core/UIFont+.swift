
//
//  UIFont+.swift
//  Messaging
//
//  Created by Cyril on 02/07/2017.
//  Copyright © 2017 Cyril. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static func flFontMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    static func flFontThin(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Thin", size: size)!
    }
    
    static func flFontBold(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    
    static func flFontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size)!
    }
}
