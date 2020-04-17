//
//  TemperatureHorizontalBarComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct TemperatureHorizontalBarComponent: View {
    
    // MARK: - Properties
    var minTemperature: Int
    var maxTemperature: Int
    
    private let maxTemperatureAuthorizedFahrenheit: Float = 113 // 45°C
    private let minTemperatureAuthorizedFahrenheit: Float = 14 // -10°C

    private let maxWidth: CGFloat = UIScreen.main.bounds.width / 2
    private let minWidth: CGFloat = 80

    private var width: CGFloat {
        var temperatureFahrenheit: Float

        if Locale.preferredLocale.usesMetricSystem {
            temperatureFahrenheit = (Float(maxTemperature) * 9 / 5) + 32
        } else {
            temperatureFahrenheit = Float(maxTemperature)
        }

         let temperaturePercentage = ((temperatureFahrenheit - minTemperatureAuthorizedFahrenheit) / (maxTemperatureAuthorizedFahrenheit - minTemperatureAuthorizedFahrenheit))
        let width = CGFloat(temperaturePercentage) * maxWidth

        return max(minWidth, width)
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            Text("\(minTemperature)°")
                .font(.caption)
                .padding(8)
                .background(Color.sunFlowerDarker)
                .accessibility(label: Text(R.string.localizable.minimum_temperature()))
                .accessibility(value: Text("\(minTemperature)°"))
            
            Spacer()
            
            Text("\(maxTemperature)°")
                .font(.caption)
                .fontWeight(.bold)
                .padding(8)
                .accessibility(label: Text(R.string.localizable.maximum_temperature()))
                .accessibility(value: Text("\(maxTemperature)°"))
        }
        .frame(width: width)
        .background(Color.sunFlower)
        .cornerRadius(4)
    }
}

struct TemperatureHorizontalBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TemperatureHorizontalBarComponent(minTemperature: 48,
                                              maxTemperature: 69)
            
            TemperatureHorizontalBarComponent(minTemperature: 48,
                                              maxTemperature: 69)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
        
    }
}
