//
//  StoreConnector.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct StoreConnector<StoreState: ReduxState, V: View>: View {
    
    // MARK: - Properties
    @EnvironmentObject var store: Store<StoreState>
    let content: (StoreState, @escaping (Action) -> Void) -> V
    
    // MARK: - Body
    var body: V {
        content(store.state, store.dispatch(action:))
    }
}
