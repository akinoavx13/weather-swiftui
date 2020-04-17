//
//  AsyncActionsMiddleware.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

// swiftlint:disable opening_brace
let asyncActionsMiddleware: Middleware<ReduxState> = { dispatch, getState in
    { next in
        { action in
            if let action = action as? AsyncAction {
                action.execute(state: getState(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}
// swiftlint:enable opening_brace
