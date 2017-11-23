//
//  File.swift
//  Freelancer
//
//  Created by Cyril on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation

struct FLLogin: Codable {
    var status: FLStatus
    var result: FLLoginResult
    
    struct FLLoginResult: Codable {
        var token: String
        var user: Int
    }
    
    enum FLStatus: String, Codable {
        case success
        case error
    }
}
