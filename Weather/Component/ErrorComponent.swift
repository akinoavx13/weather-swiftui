//
//  ErrorComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 19/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct ErrorComponent: View {
    
    // MARK: - Properties
    var message: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text("Whooops")
                .font(.title)
                .fontWeight(.bold)
                .accessibility(addTraits: .isHeader)
            
            Text(message)
                .multilineTextAlignment(.center)
            
            Text("🙁")
                .font(.title)
        }
    }
}

struct ErrorComponent_Previews: PreviewProvider {
    static var previews: some View {
        ErrorComponent(message: R.string.localizable.location_error_message())
    }
}
