//
//  ApiEndpoint.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

public protocol RequestBuilder {
    
    associatedtype RequestDataType

    // MARK: - Methods
    func buildRequest(parameters: RequestDataType) throws -> Request
}

public protocol ResponseParser {
    
    associatedtype ResponseDataType
    
    // MARK: - Methods
    func parseResponse(data: Data) throws -> ResponseDataType
}

public typealias ApiEndpoint = RequestBuilder & ResponseParser
