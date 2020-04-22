//
//  LocationServiceContract.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift
import CoreLocation

protocol LocationServiceContract {
    
    // MARK: - Properties
    var location: BehaviorSubject<CLLocation?> { get }
    var locality: BehaviorSubject<String> { get }
    
    // MARK: - Methods
    func refreshLocation()
    func stopUpdatingLocation()

}
