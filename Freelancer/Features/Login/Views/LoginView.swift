//
//  LoginView.swift
//  Freelancer
//
//  Created by Cyril Cermak on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol LoginViewDelegate: class {
	func didClickLogin(with username: String?, and password: String?)
}

class LoginView: BaseView, BaseViewProtocol {
	
	weak var delegate: LoginViewDelegate?
	
	let tableView = UITableView(frame: CGRect.zero, style: .grouped)
	let loginButton = UIButton()
	var cells: [LoginCell]!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.initView()
		self.addCells()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func initView() {
		self.addSubviews()
		self.setBg()
		self.setTableView()
		self.setLoginButton()
	}
	
	func addSubviews() {
		for view in [tableView, loginButton] {
			self.addSubview(view)
		}
	}
	
	private func setBg() {
		
	}
	
	private func setTableView() {
		self.tableView.isScrollEnabled = false
		self.tableView.separatorStyle = .none
		self.tableView.backgroundColor = .clear
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(LoginCell.self, forCellReuseIdentifier: "LoginCell")
		self.tableView.snp.makeConstraints { (make) in
			make.left.right.top.equalTo(self)
			make.height.equalTo(250)
		}
	}
	
	private func setLoginButton() {
		self.loginButton.setTitle("LOGIN", for: .normal)
		self.loginButton.backgroundColor = UIColor.white
		self.loginButton.layer.cornerRadius = 20
		self.loginButton.setTitleColor(UIColor.flBlue(), for: .normal)
		self.loginButton.addTarget(self, action: #selector(self.didClickLogin), for: .touchUpInside)
		self.loginButton.snp.makeConstraints { (make) in
			make.left.equalTo(self)
			make.right.equalTo(self)
			make.top.equalTo(self.tableView.snp.bottom)
			make.height.equalTo(50)
		}
	}
	
	private func addCells() {
		let emailModel = LoginCellModel(imageName: "email", placeholder: "EMAIL", type: LoginCellType.email)
		let passwordModel = LoginCellModel(imageName: "password", placeholder: "PASSWORD", type: LoginCellType.password)
		let emailCell = LoginCell()
		let passwordCell = LoginCell()
		emailCell.model = emailModel
		passwordCell.model = passwordModel
		
		self.cells = [emailCell,passwordCell]
	}
	
	@objc func didClickLogin() {
		let email = self.cells[0].textField.text
		let password = self.cells[1].textField.text
		self.delegate?.didClickLogin(with: email, and: password)
	}
}

extension LoginView: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return self.cells[indexPath.section]
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 30
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		return UIView()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return LoginCell.cellHeight
	}
}
