//
//  ReloadButtonComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 17/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct ReloadButtonComponent: View {
    
    // MARK: - Properties
    var lastUpdate: Date
    
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                store.dispatch(action: WeatherAction.FetchForecast())
            }, label: {
                VStack {
                    HStack(alignment: .center) {
                        Text(R.string.localizable.reload())
                            .foregroundColor(.primary)
                    }
                    
                    Text(R.string.localizable.last_update(lastUpdate.format(format: "HH:mm")))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            })
            
            Spacer()
        }
    }
}

#if DEBUG

struct ReloadButtonComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ReloadButtonComponent(lastUpdate: Date())
                .environment(\.colorScheme, .light)
            
            ReloadButtonComponent(lastUpdate: Date())
                .environment(\.colorScheme, .dark)
        }
        
    }
}

#endif
