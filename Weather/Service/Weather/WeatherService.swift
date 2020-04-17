//
//  WeatherService.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

final class WeatherService: WeatherServiceContract {

    // MARK: - Properties
    let apiRequester = ApiRequester()
    
    // MARK: - Methods
    func forecast(latitude: Double, longitude: Double) -> Single<Forecast> {
        apiRequester.fetch(ForecastEndpoint(), with: (latitude, longitude))
    }
    
}
