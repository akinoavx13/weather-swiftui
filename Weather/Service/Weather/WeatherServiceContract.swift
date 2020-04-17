//
//  WeatherServiceContract.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

protocol WeatherServiceContract {
    
    func forecast(latitude: Double, longitude: Double) -> Single<Forecast>
    
}
