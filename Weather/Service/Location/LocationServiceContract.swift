//
//  LocationServiceContract.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import CoreLocation
import RxCocoa

protocol LocationServiceContract {
    
    // MARK: - Properties
    var location: PublishRelay<CLLocation> { get }
    var locality: PublishRelay<String> { get }
    var error: BehaviorRelay<Error?> { get }
    
    // MARK: - Methods
    func refreshLocation()
    func stopUpdatingLocation()

}
