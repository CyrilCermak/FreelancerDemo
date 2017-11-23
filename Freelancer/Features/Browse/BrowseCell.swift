//
//  BrowseCell.swift
//  Freelancer
//
//  Created by Cyril Cermak on 23/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import UIKit

class BrowseCell: BaseCell {
	
	static let height:CGFloat = 175
	
	let channelImage = UIImageView()
	let title = UILabel()
	let descriptionLabel = UILabel()
	let bidsLabel = UILabel()
	let bottomLine = UIView()
	
	var project: FLProject? { didSet { self.setCell(for: project!)} }
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: .default, reuseIdentifier: reuseIdentifier)
		initView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func initView() {
		self.addSubviews()
		self.setChannelImage()
		self.setTitle()
		self.setDescription()
		self.setBidsLabel()
		self.setBottomLine()
	}
	
	private func addSubviews() {
		for view in [bidsLabel, channelImage, title, descriptionLabel, bottomLine] {
			self.contentView.addSubview(view)
		}
	}
	
	private func setChannelImage() {
		self.channelImage.contentMode = .scaleAspectFit
		self.channelImage.snp.makeConstraints { (make) in
			make.left.equalTo(self.contentView).offset(10)
			make.centerY.equalTo(self.contentView)
			make.width.equalTo(55)
			make.height.equalTo(55)
		}
	}
	
	private func setTitle() {
		self.title.numberOfLines = 1
		self.title.font = UIFont.appFontBold(withSize: 20)
		self.title.snp.makeConstraints { (make) in
			make.left.equalTo(self.channelImage.snp.right).offset(10)
			make.top.equalTo(self.contentView).offset(10)
			make.right.equalTo(self.contentView).offset(-10)
			make.height.equalTo(25)
		}
	}
	
	private func setDescription() {
		self.descriptionLabel.font = UIFont.appFont(withSize: 16)
		self.descriptionLabel.numberOfLines = 0
		self.descriptionLabel.textAlignment = .left
		self.descriptionLabel.adjustsFontSizeToFitWidth = true
		self.descriptionLabel.sizeToFit()
		self.descriptionLabel.snp.makeConstraints { (make) in
			make.left.equalTo(self.title)
			make.top.equalTo(self.title.snp.bottom).offset(5)
			make.right.equalTo(self.contentView).offset(-10)
			make.bottom.equalTo(self.contentView).inset(50)
		}
	}
	
	private func setBidsLabel() {
		self.bidsLabel.textAlignment = .right
		self.bidsLabel.snp.makeConstraints { (make) in
			make.right.equalTo(self.contentView).offset(-10)
			make.width.equalTo(250)
			make.height.equalTo(20)
			make.bottom.equalTo(self.contentView).offset(-10)
		}
	}
	
	private func setBottomLine() {
		self.bottomLine.backgroundColor = UIColor(red: 0.957, green: 0.957, blue: 0.957, alpha: 1.00)
		self.bottomLine.snp.makeConstraints { (make) in
			make.left.equalTo(self.title)
			make.bottom.equalTo(self.contentView)
			make.right.equalTo(self.contentView)
			make.height.equalTo(1)
		}
	}
	
	private func setCell(for project: FLProject) {
		self.channelImage.image = UIImage(named: "profile")
		self.title.text = project.title
		self.descriptionLabel.text = project.preview_description
		if let min = project.budget.minimum, let max = project.budget.maximum {
			self.bidsLabel.text = "\(min) - \(max) \(project.currency.code)"
		}
	}
	
}
