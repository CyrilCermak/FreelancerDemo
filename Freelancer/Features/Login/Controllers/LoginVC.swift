//
//  LoginVC.swift
//  Freelancer
//
//  Created by Cyril Cermak on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import UIKit

protocol LoginDelegate: class {
    func userDidLogin()
}

class LoginVC: BaseVC {
    weak var delegate: LoginDelegate?
    
    let loginView = LoginView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.initView()
	}
	
	private func initView() {
		self.addSubviews()
		self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bgGradient")!)
		self.setLoginView()
	}
	
	func addSubviews() {
		self.view.addSubview(loginView)
	}
	
	private func setLoginView() {
		self.loginView.delegate = self
		self.loginView.snp.makeConstraints { (make) in
			make.top.equalTo(self.view).offset(50)
			make.left.equalTo(self.view).offset(30)
			make.right.equalTo(self.view).inset(30)
			make.bottom.equalTo(self.view)
		}
	}
	
}

extension LoginVC: LoginViewDelegate {
	func didClickLogin(with username: String?, and password: String?) {
		guard let username = username, let password = password else { return self.showLoginError() }
		FreelancerService.main.tryLogin(with: username, and: password) { (loggedIn) in
			loggedIn ? self.delegate?.userDidLogin() : self.showLoginError()
		}
	}
	
	private func showLoginError() {
		self.showErrorMessage(FLError(localizedTitle: "Oooops could not login!", localizedDescription: "Please check your credentials.", code: 500))
	}
}
