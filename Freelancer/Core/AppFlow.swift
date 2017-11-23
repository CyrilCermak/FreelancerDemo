//
//  AppFlow.swift
//  PFC
//
//  Created by Cyril on 8/8/17.
//  Copyright © 2017 Cyril. All rights reserved.
//

import Foundation
import UIKit

class AppFlow {
    
    var navigation: CCNavigationController!
    
    init() {
        self.presentWalkthrough()
//		self.navigation = CCNavigationController(rootViewController: ToolbarRootVC())
    }
    
    func currentViewController() -> UIViewController? {
        return self.navigation.viewControllers.first
    }
    
    func presentWalkthrough() {
        let walkthroughVC = WalkthroughVC()
        walkthroughVC.delegate = self
        self.navigation = CCNavigationController(rootViewController: walkthroughVC)
        self.navigation.isNavigationBarHidden = true
    }
    
    func presentLogin() {
        let loginVC = LoginVC()
		loginVC.delegate = self
        self.navigation.pushViewController(loginVC, animated: true)
    }
}

extension AppFlow: WalkthroughVCDelegate {
    func didFinishFlow() {
        presentLogin()
    }
}

extension AppFlow: LoginDelegate {
	func userDidLogin() {
		self.presentToolbarVC()
	}
}

extension AppFlow: ToolbarRootVCDelegate {
	func presentToolbarVC() {
		let toolbarVC = ToolbarRootVC()
		toolbarVC.delegate = self
		self.navigation.viewControllers.removeAll()
		self.navigation.pushViewController(toolbarVC, animated: true)
	}
	
	func didSelectMyProjects(at vc: ToolbarRootVC) {
		vc.addVCToContainer(vc.myProjectsVC)
	}
	func didSelectBrowse(at vc: ToolbarRootVC) {
		vc.addVCToContainer(vc.browseVC)
	}
	func didSelectProfile(at vc: ToolbarRootVC) {
		vc.addVCToContainer(vc.userProfileVC)
	}
}

