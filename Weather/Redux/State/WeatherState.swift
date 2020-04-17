//
//  WeatherState.swift
//  Deezer
//
//  Created by Maxime Maheo on 10/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

struct WeatherState: ReduxState {
    var forecast: Forecast?
    var isLoading: Bool = false
}
