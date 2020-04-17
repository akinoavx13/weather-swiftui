//
//  HumidityComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 15/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct HumidityComponent: View {
    
    // MARK: - Properties
    var precipitationProbability: Float
    var icon: UIImage?
    var imageDescription: String
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            Text("\(Int(precipitationProbability * 100))%")
                .font(.caption)
                .accessibility(label: Text("Precipication"))
                .accessibility(value: Text("\(Int(precipitationProbability * 100))%"))
            
            WeatherIconComponent(icon: icon,
                                 size: 35,
                                 imageDescription: imageDescription)
        }
        .frame(minWidth: 90, minHeight: 40)
    }
}

struct HumidityComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HumidityComponent(precipitationProbability: 1,
                              icon: R.image.icn_weather_rain(),
                              imageDescription: "sun")
            
            HumidityComponent(precipitationProbability: 0.4,
                              icon: R.image.icn_weather_rain(),
                              imageDescription: "sun")
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
        
    }
}
