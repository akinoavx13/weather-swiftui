//
//  Unwrap.swift
//  Weather
//
//  Created by Maxime Maheo on 23/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct Unwrap<Value, Content: View>: View {
    
    // MARK: - Properties
    private let value: Value?
    private let contentProvider: (Value) -> Content

    // MARK: - Body
    var body: some View {
        value.map(contentProvider)
    }
    
    // MARK: - Lifecycle
    init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        self.contentProvider = content
    }

}
