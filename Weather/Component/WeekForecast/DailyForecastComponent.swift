//
//  DailyForecastComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct DailyForecastComponent: View {
    
    // MARK: - Properties
    var date: Date
    var temperatureMin: Int
    var temperatureMax: Int
    var precipitationProbability: Float
    var icon: UIImage?
    var imageDescription: String
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .center) {
                Text(date.format(format: "EE"))
                    .font(.callout)
                    .fontWeight(.medium)
                    .accessibility(label: Text(date.format(format: "EEEE dd")))
                
                Text(date.format(format: "dd"))
                    .font(.caption)
                    .accessibility(hidden: true)
            }
            .frame(minWidth: 60, minHeight: 40)
            
            HumidityComponent(precipitationProbability: precipitationProbability,
                              icon: icon,
                              imageDescription: imageDescription)

            TemperatureHorizontalBarComponent(minTemperature: temperatureMin,
                                              maxTemperature: temperatureMax)
            
            Spacer()
        }
    }
}

struct DailyForecastComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DailyForecastComponent(date: Date(),
                                   temperatureMin: 45,
                                   temperatureMax: 68,
                                   precipitationProbability: 0.5,
                                   icon: R.image.icn_weather_rain(),
                                   imageDescription: "sun")
            
            DailyForecastComponent(date: Date(),
                                   temperatureMin: 45,
                                   temperatureMax: 68,
                                   precipitationProbability: 0.5,
                                   icon: R.image.icn_weather_rain(),
                                   imageDescription: "sun")
            .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
            .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
        }
    }
}
