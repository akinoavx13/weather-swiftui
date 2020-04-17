//
//  Store.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class Store<StoreState: ReduxState>: ObservableObject {
    
    // MARK: - Properties
    @Published var state: StoreState

    private var dispatchFunction: DispatchFunction!
    private let reducer: Reducer<StoreState>
    
    // MARK: - Lifecycle
    init(reducer: @escaping Reducer<StoreState>, middleware: [Middleware<StoreState>] = [], state: StoreState) {
        self.reducer = reducer
        self.state = state
        
        var middleware = middleware
        
        middleware.append(asyncActionsMiddleware)
        self.dispatchFunction = middleware
            .reversed()
            .reduce({ [unowned self] action in
                self._dispatch(action: action)
            }, { dispatchFunction, middleware in
                let dispatch: (Action) -> Void = { [weak self] in self?.dispatch(action: $0) }
                let getState = { [weak self] in self?.state }
                
                return middleware(dispatch, getState)(dispatchFunction)
            })
    }

    // MARK: - Methods
    func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    // MARK: - Private methods
    private func _dispatch(action: Action) {
        state = reducer(state, action)
    }
}
