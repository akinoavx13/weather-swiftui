//
//  SharedSequence+Unwrap.swift
//  Weather
//
//  Created by Maxime Maheo on 22/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import RxCocoa

extension SharedSequence {

    /**
     Takes a SharedSequence of optional elements and returns a SharedSequence of non-optional elements, filtering out any nil values.
     
        - returns: A SharedSequence of non-optional elements
     */

    public func unwrap<Result>() -> SharedSequence<SharingStrategy, Result> where Element == Result? {
        self.filter { $0 != nil }.map { $0! }
    }
}
