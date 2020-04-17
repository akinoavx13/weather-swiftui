//
//  AppDependency.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

final class AppDependency {
    
    // MARK: - Properties
    static let shared = AppDependency()
    
    let servicesContainer = DependenciesContainer()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func registerServices() {
        registerWeatherService()
        registerLocationService()
    }
    
    // MARK: - Private methods
    private func registerWeatherService() {
        let service = WeatherService()
            
        AppDependency.shared.servicesContainer.register(WeatherServiceContract.self, factory: { service })
    }
    
    private func registerLocationService() {
        let service = LocationService()
            
        AppDependency.shared.servicesContainer.register(LocationServiceContract.self, factory: { service })
    }
    
}
