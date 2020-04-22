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
    case cannotProvideLocality
}

final class LocationService: NSObject, LocationServiceContract {

    // MARK: - Properties
    private let manager = CLLocationManager()
    private var location: PublishSubject<CLLocation> = .init()
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        
        manager.delegate = self
    }
    
    // MARK: - Methods
    func getUserLocation() -> Single<CLLocation> {
        if !CLLocationManager.locationServicesEnabled() {
            return Single.error(LocationServiceError.locationServicesNotEnabled)
        }
                
        return Single.create { [weak self] (single) in
            guard let self = self else {
                single(.error(LocationServiceError.selfIsNil))

                return Disposables.create()
            }
            
            self.location
                .subscribe(onNext: { [weak self] (location) in
                    single(.success(location))
                    
                    self?.disposeBag = DisposeBag()
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
        getUserLocation()
            .flatMap { self.convertLocationToLocality(location: $0) }
    }
       
    // MARK: - Methods
    private func convertLocationToLocality(location: CLLocation) -> Single<String> {
        Single.create { (single) in
            CLGeocoder()
                .reverseGeocodeLocation(location) { (placemarks, error) in
                    guard error == nil else {
                        return single(.error(error!))
                    }
                    
                    guard
                        let firstPlacemark = placemarks?[0],
                        let locality = firstPlacemark.locality,
                        let country = firstPlacemark.country
                    else {
                        return single(.error(LocationServiceError.cannotProvideLocality))
                    }
                                        
                    single(.success("\(locality), \(country)"))
                }
            
            return Disposables.create()
        }
    }
        
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) { }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location.on(.next(location))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location.on(.error(error))
    }
}
