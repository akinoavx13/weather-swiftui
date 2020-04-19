//
//  ForecastEndpoint.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

final class ForecastEndpoint: ApiEndpoint {
    
    typealias RequestDataType = (latitude: Double, longitude: Double)
    typealias ResponseDataType = Forecast
    
    // MARK: - Methods
    func buildRequest(parameters: ForecastEndpoint.RequestDataType) throws -> Request {
        let baseStringUrl = "https://api.darksky.net/forecast"
        
        guard
            let request = DarkSkyRequest(baseStringUrl: baseStringUrl,
                                         apiKey: DarkSky.apiKey,
                                         latitude: parameters.latitude,
                                         longitude: parameters.longitude,
                                         language: Locale.language,
                                         unit: Locale.preferredLocale.usesMetricSystem ? "si" : "us")
        else {
            throw RequestError.failedToRequestWithUrl(baseStringUrl)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> ForecastEndpoint.ResponseDataType {
        try JSONDecoder().decode(Forecast.self, from: data)
    }
}
