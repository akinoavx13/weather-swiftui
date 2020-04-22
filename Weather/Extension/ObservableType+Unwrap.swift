//
//  ObservableType+Unwrap.swift
//  Weather
//
//  Created by Maxime Maheo on 22/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxSwift

extension ObservableType {

    /**
     Takes a sequence of optional elements and returns a sequence of non-optional elements, filtering out any nil values.
     
        - returns: An observable sequence of non-optional elements
     */
    public func unwrap<Result>() -> Observable<Result> where Element == Result? {
        self.compactMap { $0 }
    }
}
