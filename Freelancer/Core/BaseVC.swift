//
//  BaseVC.swift
//  Messaging
//
//  Created by Cyril on 08/05/17.
//  Copyright © 2017 Cyril. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        print("BaseVC: \(self.classForCoder) did load")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.view.backgroundColor = UIColor.appLightGrey()
    }
    
    func showErrorMessage(_ error: FLError) {
        let alertVC = UIAlertController(title: error.localizedTitle , message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            alertVC.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}
