//
//  DarkSkyRequest.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class DarkSkyRequest: BaseRequest {
    
    // MARK: - Properties
    private let language: String
    private let unit: String
    
    override var urlRequest: URLRequest {
        var request = super.urlRequest
        let parameters = [
            "lang": language,
            "units": unit
        ]
        
        request.addQueryParameters(parameters: parameters)
        
        return request
    }
    
    // MARK: - Lifecycle
    init?(baseStringUrl: String,
          apiKey: String,
          latitude: Double,
          longitude: Double,
          language: String,
          unit: String) {
        self.language = language
        self.unit = unit
        
        super.init(baseStringUrl: "\(baseStringUrl)/\(apiKey)/\(latitude),\(longitude)")
    }
    
}
