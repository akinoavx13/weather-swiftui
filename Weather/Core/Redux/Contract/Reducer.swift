//
//  Reducer.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

typealias Reducer<ReducerStateType> = (_ state: ReducerStateType, _ action: Action) -> ReducerStateType
