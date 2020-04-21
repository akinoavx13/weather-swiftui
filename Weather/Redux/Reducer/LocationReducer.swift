//
//  LocationReducer.swift
//  Weather
//
//  Created by Maxime Maheo on 21/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

func locationReducer(state: LocationState, action: Action) -> LocationState {
    var state = state
    
    switch action {
    case let action as LocationAction.SetLocality:
        state.locality = action.locality
    case let action as LocationAction.SetError:
        store.dispatch(action: AppAction.SetError(error: action.error))
    default:
        break
    }
    
    return state
}
