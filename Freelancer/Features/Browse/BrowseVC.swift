//
//  BrowseVC.swift
//  Freelancer
//
//  Created by Cyril Cermak on 23/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation

class BrowseVC: BaseVC {
	
	let browseView = BrowseView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .red
		self.initView()
		self.getProjects()
	}
	
	private func initView() {
		self.view.addSubview(self.browseView)
		self.browseView.snp.makeConstraints { (make) in
			make.edges.equalTo(self.view)
		}
	}
	
	private func getProjects() {
		FreelancerService.main.getProjects { (projects) in
			self.browseView.projects = projects
		}
	}
	
	
}
