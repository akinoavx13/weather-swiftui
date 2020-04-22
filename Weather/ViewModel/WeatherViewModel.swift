//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Maxime Maheo on 22/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation
import Combine
import RxSwift

final class WeatherViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var forecast: Forecast?
    @Published var lastUpdate: Date = Date()
    @Published var error: WeatheryError?
    
    private var weatherService: WeatherServiceContract
    private var locationService: LocationServiceContract
    
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    init() {
        guard let weatherService = AppDependency.shared.servicesContainer.resolve() as WeatherServiceContract? else {
            fatalError("Could not resolve weather service")
        }
        guard let locationService = AppDependency.shared.servicesContainer.resolve() as LocationServiceContract? else {
            fatalError("Could not resolve location service")
        }
                
        self.weatherService = weatherService
        self.locationService = locationService
        
        bindLocation()
        bindLocationError()
    }
    
    // MARK: - Private methods
    private func bindLocation() {
        locationService
            .location
            .subscribe(onNext: { [weak self] (location) in
                self?.fetchForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindLocationError() {
        locationService
            .error
            .unwrap()
            .asDriver(onErrorJustReturn: WeatheryError.generic)
            .drive(onNext: { [weak self] (error) in
                guard let self = self else { return }

                self.error = WeatheryError(error: error)
                self.locationService.stopUpdatingLocation()
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchForecast(latitude: Double, longitude: Double) {
        error = nil
        
        weatherService
            .forecast(latitude: latitude, longitude: longitude)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (forecast) in
                guard let self = self else { return }
                
                self.forecast = forecast
                self.lastUpdate = Date()
            }, onError: { [weak self] (error) in
                guard let self = self else { return }

                self.error = WeatheryError(error: error)
                self.locationService.stopUpdatingLocation()
            })
            .disposed(by: disposeBag)
    }
}
