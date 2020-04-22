//
//  LocationService.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift
import CoreLocation
import RxCocoa

enum LocationServiceError: Error {
    case selfIsNil
    case locationServicesNotEnabled
    case cannotProvideLocality
}

final class LocationService: NSObject, LocationServiceContract {

    // MARK: - Properties
    var location: PublishRelay<CLLocation> = .init()
    var locality: PublishRelay<String> = .init()
    var error: BehaviorRelay<Error?> = .init(value: nil)
    
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
        stopUpdatingLocation()
        manager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    // MARK: - Private methods
    private func convertLocationToLocality(location: CLLocation) {
        CLGeocoder()
            .reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
                guard let self = self else { return }
                
                if error != nil {
                    return self.error.accept(error!)
                }
                
                guard let firstPlacemark = placemarks?[0] else {
                    return self.error.accept(LocationServiceError.cannotProvideLocality)
                }
                
                let locality = [firstPlacemark.locality, firstPlacemark.country]
                    .filter { $0 != nil }
                    .map { $0 ?? "" }
                    .joined(separator: ", ")
                
                self.locality.accept(locality)
            }
    }

}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) { }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location.accept(location)
            convertLocationToLocality(location: location)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.error.accept(error)
    }
}
