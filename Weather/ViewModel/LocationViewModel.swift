//
//  LocationViewModel.swift
//  Weather
//
//  Created by Maxime Maheo on 22/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation
import Combine
import RxSwift

final class LocationViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var locality: String = ""
    @Published var error: WeatheryError?

    private var locationService: LocationServiceContract
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    init() {
        guard let locationService = AppDependency.shared.servicesContainer.resolve() as LocationServiceContract? else {
            fatalError("Could not resolve location service")
        }
                
        self.locationService = locationService
    }
    
    // MARK: - Methods
    func fetchLocality() {
        locationService
            .getLocality()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (locality) in
                self?.locality = locality
            }, onError: { [weak self] (error) in
                self?.error = WeatheryError(error: error)
            })
            .disposed(by: disposeBag)
    }
}
