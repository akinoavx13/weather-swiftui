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
    var location: PublishSubject<CLLocation> = .init()
    var locality: BehaviorSubject<String> = .init(value: "")
    
    private let manager = CLLocationManager()
    private var disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    override init() {
        super.init()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func refreshLocation() {
        manager.stopUpdatingLocation()
        manager.startUpdatingLocation()
    }
    
    // MARK: - Private methods
    private func convertLocationToLocality(location: CLLocation) {
        CLGeocoder()
            .reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if error != nil {
                    return self.locality.onError(error!)
                }
                
                guard
                    let firstPlacemark = placemarks?[0],
                    let locality = firstPlacemark.locality,
                    let country = firstPlacemark.country
                else {
                    return self.locality.onError(LocationServiceError.cannotProvideLocality)
                }
                
                self.locality.onNext("\(locality), \(country)")
            }
    }

}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) { }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location.on(.next(location))
            convertLocationToLocality(location: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location.on(.error(error))
    }
}
