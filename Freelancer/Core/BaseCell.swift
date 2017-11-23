//
//  BaseCell.swift
//  Freelancer
//
//  Created by Cyril Cermak on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import UIKit

class BaseCell: UITableViewCell {
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
