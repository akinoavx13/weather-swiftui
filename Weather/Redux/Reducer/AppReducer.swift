//
//  AppReducer.swift
//  Deezer
//
//  Created by Maxime Maheo on 09/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

func appReducer(state: AppState, action: Action) -> AppState {
    var state = state
    
    state.weatherState = weatherReducer(state: state.weatherState, action: action)
    
    return state
}
