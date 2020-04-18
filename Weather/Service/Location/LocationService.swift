//
//  LocationService.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreLocation

final class LocationService: NSObject, LocationServiceContract {

    // MARK: - Properties
    private let manager = CLLocationManager()
    private var userLocation: PublishRelay<CLLocation> = .init()
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    // MARK: - Methods
    func getUserLocation() -> Single<CLLocation> {
        if !CLLocationManager.locationServicesEnabled() {
            return Single.never()
        }
        
        return Single.create { [weak self] (single) in
            guard let self = self else { return Disposables.create() }
        
            self.userLocation
                .subscribe(onNext: { (location) in
                    single(.success(location))
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
            userLocation.accept(location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) { }
}
