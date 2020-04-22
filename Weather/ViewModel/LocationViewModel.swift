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

    private var locationService: LocationServiceContract
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    init() {
        guard let locationService = AppDependency.shared.servicesContainer.resolve() as LocationServiceContract? else {
            fatalError("Could not resolve location service")
        }
                
        self.locationService = locationService
        
        bindLocation()
        bindLocationError()
    }
    
    // MARK: - Methods
    func refreshLocation() {
        locationService.refreshLocation()
    }
    
    // MARK: - Private methods
    private func bindLocation() {
        locationService
            .locality
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (locality) in
                self?.locality = locality
            })
            .disposed(by: disposeBag)
    }
    
    private func bindLocationError() {
        locationService
            .error
            .unwrap()
            .asDriver(onErrorJustReturn: WeatheryError.generic)
            .drive(onNext: { [weak self] (_) in
                self?.locationService.stopUpdatingLocation()
            })
            .disposed(by: disposeBag)
    }
}
