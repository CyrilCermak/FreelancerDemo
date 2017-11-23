//
//  FLProject.swift
//  Freelancer
//
//  Created by Cyril Cermak on 23/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation

struct FLPRojects: Codable {
	var status: FLStatus
	var result: Result
	
	struct Result: Codable {
		var projects: [FLProject]
	}
	
	enum FLStatus: String, Codable {
		case success
		case error
	}
}

struct FLProject: Codable {
	var title: String
	var description: String
	var preview_description: String
	var currency: FLCurrency
	var budget: FLBudget
	
	struct FLCurrency: Codable {
		var code: String
		var name: String
		var country: String
		var sign: String
		var exchange_rate: Double
	}
	
	struct FLBudget: Codable {
		var currency_id: Int?
		var minimum: Double?
		var maximum: Double?
		var project_type: Int?
	}
}

