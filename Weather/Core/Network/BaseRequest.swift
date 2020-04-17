//
//  BaseRequest.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

class BaseRequest: Request {
    
    // MARK: - Properties
    private var request: URLRequest
    
    var urlRequest: URLRequest {
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                
        return request
    }
    
    // MARK: - Lifecycle
    init?(baseStringUrl: String) {
        guard let url = URL(string: baseStringUrl) else { return nil }
        
        self.request = URLRequest(url: url)
    }
    
}
