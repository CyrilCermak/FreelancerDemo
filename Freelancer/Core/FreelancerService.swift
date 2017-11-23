//
//  FreelancerService.swift
//  Freelancer
//
//  Created by Cyril on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation

class FreelancerService {
    
    static let main = FreelancerService()
	let networkManager = FLNetworkManager()
	let baseURL = "https://www.freelancer.com/api"
	let loginUrl = "https://accounts.freelancer-sandbox.com/oauth/authorise"
	let projects = "/projects/0.1/projects"
    
    func tryLogin(with username: String, and password: String, completion:@escaping(_ isLoggedIn: Bool) -> Void) {
        let params = ["user":username, "password":password]
		//Login must be done through OAUTH2 based on the docs so this is not relevant with new API anymore, use OAUTHSwift library and follow the freelancer docs.
		completion(true)
//        networkManager.postRequest(for: loginUrl, with: params, headers: nil) { (jsonData, error) in
//            guard error == nil else { return }
//            if let data = jsonData {
//                do {
//                    let flLogin = try JSONDecoder().decode(FLLogin.self, from: data)
//                    return completion(true)
//                } catch let error {
//					print(error)
//                    completion(false)
//                }
//            }
//        }
    }
	
	func getProjects(completion:@escaping(_ projects: [FLProject]) -> Void) {
		let params: [String:String] = ["full_description":"true","job_details":"true","upgrade_details":"true","user_details":"true","selected_bids":"true","location_details":"","owners[]":"17006839","frontend_project_statuses[]":"open","limit":"10","offset":"1"]
		let url = baseURL.appendingPathComponent(projects)
		networkManager.getRequest(for: projects, with: params, headers: nil) { (jsonData, error) in
			guard error == nil else { return }
			if let data = jsonData {
				do {
					let flProjects = try JSONDecoder().decode(FLPRojects.self, from: data)
					completion(flProjects.result.projects)
				} catch let e {
					print(e)
					completion([])
				}
			}
		}
	}
    
}
