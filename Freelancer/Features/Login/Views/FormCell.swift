//
//  FormCell.swift
//  Messaging
//
//  Created by Cyril on 10/05/17.
//  Copyright © 2017 Cyril. All rights reserved.
//

import Foundation
import UIKit

enum LoginCellType {
	case password
	case email
}

class LoginCellModel {
	var id: String
	var imageName: String?
	var placeholder: String
	var type: LoginCellType?
	
	init(id:String = "", imageName: String?, placeholder:String, type: LoginCellType) {
		self.id = id; self.imageName = imageName; self.placeholder = placeholder; self.type = type
	}
}

class LoginCell: BaseCell {
	
	static let cellHeight: CGFloat = 60
	
	let textField = UITextField()
	let icon = UIImageView(image: nil)
	let placeholder = UILabel()
	var cellWithIcon: Bool!
	var model: LoginCellModel? { didSet { self.setupCell(with: self.model ) } }
	
	internal var type: LoginCellType!
	
	convenience init() {
		self.init(style: .default, reuseIdentifier: "LoginCell")
		self.initView()
		self.setCell()
	}
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func initView() {
		self.addSubviews()
		self.setPlaceholder()
		self.setIcon()
		self.setTextField()
		self.addPathTo(self.textField)
	}
	
	private func setCell() {
		self.selectionStyle = .none
		self.backgroundColor = .clear
		self.contentView.backgroundColor = .clear
	}
	
	private func setPlaceholder() {
		self.placeholder.font = UIFont.flFontRegular(size: kFontSizeExtraSmall)
		self.placeholder.textColor = UIColor.white
		
		self.placeholder.snp.makeConstraints { (make) in
			make.left.equalTo(self.textField)
			make.bottom.equalTo(self.textField.snp.top)
			make.width.equalTo(100)
			make.height.equalTo(20)
		}
	}
	
	private func setIcon() {
		icon.snp.makeConstraints { (make) in
			make.width.equalTo(20)
			make.height.equalTo(20)
			make.centerY.equalTo(textField)
			make.left.leading.equalTo(self.contentView)
		}
	}
	
	private func setTextField() {
		self.textField.autocapitalizationType = .none
		self.textField.tintColor = .white
		self.textField.textColor = .white
		self.textField.snp.makeConstraints { (make) in
			make.top.equalTo(self.contentView).offset(20)
			make.right.equalTo(self.contentView)
			make.height.equalTo(30)
			make.left.equalTo(icon.snp.right).offset(30)
		}
	}
	
	private func addSubviews() {
		self.contentView.addSubview(self.textField)
		self.contentView.addSubview(icon)
		self.contentView.addSubview(placeholder)
		
	}
	
	private func addPathTo(_ textField: UITextField) {
		let path = UIView()
		path.backgroundColor = UIColor.flLightGray()
		textField.addSubview(path)
		path.snp.makeConstraints { (make) in
			make.left.equalTo(textField)
			make.bottom.equalTo(textField.snp.bottom)
			make.width.equalTo(textField)
			make.height.equalTo(1)
		}
	}
	
	private func setKeyboardType(with model: LoginCellModel) {
		guard let type = model.type else { return }
		switch type {
		case .email:
			self.textField.keyboardType = .emailAddress
		case .password:
			self.textField.isSecureTextEntry = true
		}
	}
	
	private func setupCell(with model: LoginCellModel?) {
		guard let model = model else { return }
		self.icon.image = UIImage(named: model.imageName ?? "")
		self.placeholder.text = model.placeholder
		self.setKeyboardType(with: model)
	}
	
}
