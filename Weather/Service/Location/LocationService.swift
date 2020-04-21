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
    case noLocation
}

final class LocationService: NSObject, LocationServiceContract {

    // MARK: - Properties
    private let manager = CLLocationManager()
    private var lastLocation: PublishSubject<CLLocation> = .init()
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
            
            self.lastLocation
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
    
    func getLocality() -> Single<String> {
        Single.create { [weak self] (single) in
            guard let self = self else {
                single(.error(LocationServiceError.selfIsNil))
                return Disposables.create()
            }
                    
            if let lastLocation = self.manager.location {
                let geocoder = CLGeocoder()
                
                geocoder
                    .reverseGeocodeLocation(lastLocation) { (placemarks, error) in
                        if error == nil {
                            if let firstLocation = placemarks?[0] {
                                let locality = "\(firstLocation.locality ?? ""), \(firstLocation.country ?? "")"
                                
                                single(.success(locality))
                            } else {
                                single(.error(LocationServiceError.noLocation))
                            }
                        } else {
                            single(.error(error!))
                        }
                    }
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
            lastLocation.on(.next(location))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastLocation.on(.error(error))
    }
}
