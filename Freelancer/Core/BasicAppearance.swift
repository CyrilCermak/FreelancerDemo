//
//  BasicAppearance.swift
//  Messaging
//
//  Created by Cyril on 02/07/2017.
//  Copyright © 2017 Cyril. All rights reserved.
//

import Foundation
import UIKit

class BasicAppearance {
    
    static func styleTheApp() {
        styleTheNavBar()
    }
    
    private static func styleTheNavBar() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.isTranslucent = false
        navBarAppearance.tintColor = UIColor.white
        navBarAppearance.barTintColor = UIColor.appColor()
        navBarAppearance.barStyle = .blackOpaque
		navBarAppearance.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 18)!]
		navBarAppearance.setBackgroundImage(UIImage(named: "topBar")!.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)

    }
    
}
