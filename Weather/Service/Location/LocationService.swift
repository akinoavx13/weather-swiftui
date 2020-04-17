//
//  LocationService.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift
import CoreLocation

final class LocationService: NSObject, LocationServiceContract {

    // MARK: - Properties
    private let manager = CLLocationManager()
    private var userLocation: PublishSubject<CLLocation> = .init()
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    // MARK: - Methods
    func getUserLocation() -> Single<CLLocation> {
        manager.requestWhenInUseAuthorization()
        
        return userLocation.asSingle()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .notDetermined || status == .restricted {
            manager.requestWhenInUseAuthorization()
        } else {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            userLocation.on(.next(location))
            userLocation.on(.completed)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        userLocation.on(.error(error))
    }
}
