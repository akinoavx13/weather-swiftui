//
//  LocationAction.swift
//  Weather
//
//  Created by Maxime Maheo on 21/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

struct LocationAction {
    
    struct FetchLocality: AsyncAction {
        
        // MARK: - Properties
        static let disposeBag = DisposeBag()

        // MARK: - Methods
        func execute(state: ReduxState?, dispatch: @escaping DispatchFunction) {
            guard let locationService = AppDependency.shared.servicesContainer.resolve() as LocationServiceContract? else {
                fatalError("Could not resolve location service")
            }

            locationService
                .getLocality()
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
                .subscribe(onSuccess: {
                    dispatch(SetLocality(locality: $0))
                }, onError: {
                    dispatch(SetError(error: $0))
                })
                .disposed(by: FetchLocality.disposeBag)
        }
    }
    
    struct SetError: Action {
        let error: Error
    }
    
    struct SetLocality: Action {
        let locality: String
    }
    
}
