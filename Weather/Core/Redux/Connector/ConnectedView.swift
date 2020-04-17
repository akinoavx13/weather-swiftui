//
//  ConnectedView.swift
//  CovidTracker
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

protocol ConnectedView: View {
    associatedtype StoreState: ReduxState
    associatedtype Props
    associatedtype V: View
    
    // MARK: - Methods
    func map(state: StoreState, dispatch: @escaping DispatchFunction) -> Props
    func body(props: Props) -> V
}

extension ConnectedView {
    
    // MARK: - Methods
    func render(state: StoreState, dispatch: @escaping DispatchFunction) -> V {
        let props = map(state: state, dispatch: dispatch)
        return body(props: props)
    }
    
    // MARK: - Body
    var body: StoreConnector<StoreState, V> {
        StoreConnector(content: render)
    }
}
