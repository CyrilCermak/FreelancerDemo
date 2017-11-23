//
//  BaseView.swift
//  Freelancer
//
//  Created by Cyril Cermak on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewProtocol: class {
	func initView()
	func addSubviews()
}

class BaseView: UIView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
}
