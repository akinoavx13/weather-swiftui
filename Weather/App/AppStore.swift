//
//  AppStore.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

let store = Store(reducer: appReducer, state: AppState())

#if DEBUG

let previewStore = Store<AppState>(reducer: appReducer,
                                   state: AppState(weatherState: WeatherState(forecast: Forecast(currently: DataForecast.one,
                                                                                                 hourly: DataForecasts.one,
                                                                                                 daily: DataForecasts.one,
                                                                                                 latitude: 44.837789,
                                                                                                 longitude: -0.57918),
                                                                              isLoading: true)))

#endif
