//
//  StoreProvider.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct StoreProvider<S: ReduxState, V: View>: View {
    
    // MARK: - Properties
    let store: Store<S>
    let content: () -> V
    
    // MARK: - Lifecycle
    init(store: Store<S>, content: @escaping () -> V) {
        self.store = store
        self.content = content
    }
    
    // MARK: - Body
    var body: some View {
        content().environmentObject(store)
    }
}
