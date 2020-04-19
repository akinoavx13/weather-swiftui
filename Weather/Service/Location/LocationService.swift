//
//  LocationService.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift
import CoreLocation

enum LocationServiceError: Error {
    case selfIsNil
    case locationServicesNotEnabled
}

final class LocationService: NSObject, LocationServiceContract {

    // MARK: - Properties
    private let manager = CLLocationManager()
    private var userLocation: PublishSubject<CLLocation> = .init()
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    // MARK: - Methods
    func getUserLocation() -> Single<CLLocation> {
        Single.create { [weak self] (single) in
            guard let self = self else {
                single(.error(LocationServiceError.selfIsNil))
                
                return Disposables.create()
            }
        
            if !CLLocationManager.locationServicesEnabled() {
                single(.error(LocationServiceError.locationServicesNotEnabled))
            }
            
            self.userLocation
                .subscribe(onNext: { (location) in
                    single(.success(location))
                }, onError: { (error) in
                    single(.error(error))
                })
                .disposed(by: self.disposeBag)
            
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                self.manager.requestLocation()
            } else {
                self.manager.requestWhenInUseAuthorization()
            }
            
            return Disposables.create()
        }
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
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        userLocation.on(.error(error))
    }
}
