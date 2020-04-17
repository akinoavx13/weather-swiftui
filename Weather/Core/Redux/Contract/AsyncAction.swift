//
//  AsyncAction.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

protocol AsyncAction: Action {
    func execute(state: ReduxState?, dispatch: @escaping DispatchFunction)
}
