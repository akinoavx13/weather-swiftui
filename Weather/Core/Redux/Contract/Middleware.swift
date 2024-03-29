//
//  Middleware.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

typealias DispatchFunction = (Action) -> Void
typealias Middleware<MiddlewareStateType> = (@escaping DispatchFunction, @escaping () -> ReduxState?) -> (@escaping DispatchFunction) -> DispatchFunction
