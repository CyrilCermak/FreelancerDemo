//
//  WalkthroughVC.swift
//  DisherX
//
//  Created by Cyril on 27/9/17.
//  Copyright © 2017 Cyril. All rights reserved.
//

import UserNotifications
import Foundation
import UIKit

protocol WalkthroughVCDelegate: class {
    func didFinishFlow()
}

class WalkthroughVC: BaseVC, WalkthroughViewDelegate {
    
    let walkthrouvView = WalkthroughView()
    weak var delegate: WalkthroughVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.setImages()
    }
    
    private func setImages() {
        var images = [UIImage]()
        for imageName in ["wk1","wk2","wk3"] {
            if let image = UIImage(named: imageName) {
                images.append(image)
            }
        }
        self.walkthrouvView.images = images
    }

    
    private func initView() {
        self.view.addSubview(self.walkthrouvView)
        self.setWalkthroughView()
    }
    
    private func setWalkthroughView() {
        self.walkthrouvView.delegate = self
        self.walkthrouvView.snp.makeConstraints { (make) in
//            make.top.equalTo(self.statusBarView.snp.bottom)
            make.top.left.right.bottom.equalTo(self.view)
        }
    }
    
    
    func didFinishFlow() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.delegate?.didFinishFlow()
    }
    
}
