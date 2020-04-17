//
//  LoadingComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct LoadingComponent: View {
    
    // MARK: - Properties
    @State private var degrees = 0.0
    
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Image(systemName: "arrow.2.circlepath")
                    .foregroundColor(.backgroundColorIcon)
                    .rotationEffect(.degrees(degrees))
                    .animation(Animation
                        .easeInOut(duration: 1)
                        .repeatForever(autoreverses: false)
                    )
                
                Text("\(R.string.localizable.loading()) ...")
                    .font(.subheadline)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            self.degrees = 360
        }
    }
}

#if DEBUG

struct LoadingComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoadingComponent()
            
            LoadingComponent()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
        
    }
}

#endif
