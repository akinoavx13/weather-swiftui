//
//  WeatherAction.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

struct WeatherAction {
    
    struct FetchForecast: AsyncAction {
        
        // MARK: - Properties
        static let disposeBag = DisposeBag()

        // MARK: - Methods
        func execute(state: ReduxState?, dispatch: @escaping DispatchFunction) {
            guard
                let weatherService = AppDependency.shared.servicesContainer.resolve() as WeatherServiceContract?,
                let locationService = AppDependency.shared.servicesContainer.resolve() as LocationServiceContract?
            else {
                fatalError("Could not resolve weather service or location service")
            }
            
            locationService
                .getUserLocation()
                .flatMap { weatherService.forecast(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude) }
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: { (forecast) in
                    dispatch(SetForecast(forecast: forecast))
                }, onError: { (error) in
                    dispatch(SetError(error: error))
                })
                .disposed(by: FetchForecast.disposeBag)
            
            locationService
                .getLocality()
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: {
                    dispatch(SetLocality(locality: $0))
                }, onError: {
                    dispatch(SetError(error: $0))
                })
                .disposed(by: FetchForecast.disposeBag)
        }
    }
    
    struct SetForecast: Action {
        let forecast: Forecast
    }
    
    struct SetError: Action {
        let error: Error
    }
    
    struct SetLocality: Action {
        let locality: String
    }
    
}
