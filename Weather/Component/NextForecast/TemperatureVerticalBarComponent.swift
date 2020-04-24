//
//  TemperatureVerticalBarComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct TemperatureVerticalBarComponent: View {
    
    // MARK: - Properties
    var temperature: Int
    
    private let maxTemperatureAuthorizedFahrenheit: Float = 113 // 45°C
    private let minTemperatureAuthorizedFahrenheit: Float = 14 // -10°C
    
    private let maxHeight: CGFloat = 100
    private let minHeight: CGFloat = 30

    private var height: CGFloat {
        var temperatureFahrenheit: Float
        
        if Locale.preferredLocale.usesMetricSystem {
            temperatureFahrenheit = (Float(temperature) * 9 / 5) + 32
        } else {
            temperatureFahrenheit = Float(temperature)
        }
        
         let temperaturePercentage = ((temperatureFahrenheit - minTemperatureAuthorizedFahrenheit) / (maxTemperatureAuthorizedFahrenheit - minTemperatureAuthorizedFahrenheit))
        let height = CGFloat(temperaturePercentage) * maxHeight
        
        return max(minHeight, height)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("\(temperature)°")
                .font(.caption)
                .fontWeight(.bold)
                .padding(10)
                .foregroundColor(.black)
            
            Spacer()
        }
        .frame(height: height)
        .background(Color.sunFlower)
        .cornerRadius(4)
    }
}

struct TemperatureVerticalBarComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TemperatureVerticalBarComponent(temperature: 51)
            
            TemperatureVerticalBarComponent(temperature: 51)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
}
