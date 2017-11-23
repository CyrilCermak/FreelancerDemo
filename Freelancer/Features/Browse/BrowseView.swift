//
//  BrowseView.swift
//  Freelancer
//
//  Created by Cyril Cermak on 23/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import UIKit

class BrowseView: BaseView, BaseViewProtocol, UITableViewDelegate, UITableViewDataSource {
	
	let tableView = UITableView(frame: CGRect.zero, style: .grouped)
	var projects = [FLProject]() { didSet { self.tableView.reloadData() } }
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initView()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func initView() {
		self.addSubviews()
		self.setTableView()
	}
	
	func addSubviews() {
		self.addSubview(tableView)
	}
	
	private func setTableView() {
		self.tableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0)
		self.tableView.tableHeaderView = nil
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.register(BrowseCell.self, forCellReuseIdentifier: "BrowseCell")
		self.tableView.snp.makeConstraints { (make) in
			make.edges.equalTo(self)
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.projects.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "BrowseCell") as? BrowseCell {
			cell.project = self.projects[indexPath.row]
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return BrowseCell.height
	}
	
}
