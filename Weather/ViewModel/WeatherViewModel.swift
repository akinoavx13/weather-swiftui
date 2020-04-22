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
    @Published var isLoading: Bool = false
    @Published var lastUpdate: Date = Date()
    @Published var error: WeatheryError?
    
    private var weatherService: WeatherServiceContract
    private var locationService: LocationServiceContract
    
    private let disposeBag = DisposeBag()
    
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
    }
    
    // MARK: - Methods
    func fetchForecast() {
        locationService
            .getUserLocation()
            .flatMap { self.weatherService.forecast(latitude: $0.coordinate.latitude,
                                                    longitude: $0.coordinate.longitude) }
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .do(onSuccess: { [weak self] (_) in
                self?.isLoading = false
                self?.lastUpdate = Date()
            }, onError: { [weak self] (_) in
                self?.isLoading = false
            }, onSubscribe: { [weak self] in
                self?.isLoading = true
            })
            .subscribe(onSuccess: { [weak self] (forecast) in
                self?.forecast = forecast
            }, onError: { [weak self] (error) in
                self?.error = WeatheryError(error: error)
            })
            .disposed(by: disposeBag)
    }
}
