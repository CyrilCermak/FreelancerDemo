//
//  NetworkManager.swift
//  Freelancer
//
//  Created by Cyril on 22/11/17.
//  Copyright © 2017 Cyril Cermak. All rights reserved.
//

import Foundation
import Alamofire

protocol FreelancerErrorProtocol: Error {
    var localizedTitle: String { get }
    var localizedDescription: String { get }
    var code: Int { get }
}

struct FLError: FreelancerErrorProtocol {
    
    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

class FLNetworkManager {
    var sessionManager = SessionManager()
    
    func postRequest(for url: URL, with params:[String:String]?, headers:[String:String]?, completion:@escaping(_ response: Data?, _ error: Error?) -> Void) {
        self.sessionManager.request(url, method: HTTPMethod.post, parameters: params, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let response):
                print(response)
                completion(response, nil)
            case .failure(let e): let flError = FLError(localizedTitle: "Could not download images.",
                                                        localizedDescription: e.localizedDescription,
                                                        code: response.response?.statusCode ?? 500)
            completion(nil,flError)
            }
        }
    }
    
    func getRequest(for url: URL, with params:[String:String]?, headers:[String:String]?, completion:@escaping(_ response: Data?, _ error: Error?) -> Void) {
        self.sessionManager.request(url, method: HTTPMethod.get, parameters: params, headers: headers).validate().responseData { (response) in
            switch response.result {
            case .success(let response):
                print(response)
                completion(response as? Data, nil)
            case .failure(let e): let flError = FLError(localizedTitle: "Could not download images.",
                                      localizedDescription: e.localizedDescription,
                                      code: response.response?.statusCode ?? 500)
                completion(nil,flError)
            }
        }
    }
}
