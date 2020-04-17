//
//  WeatherReducer.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

func weatherReducer(state: WeatherState, action: Action) -> WeatherState {
    var state = state
    
    switch action {
    case _ as WeatherAction.FetchForecast:
        state.isLoading = true
    case let action as WeatherAction.SetForecast:
        state.forecast = action.forecast
        state.isLoading = false
    default:
        break
    }
    
    return state
}