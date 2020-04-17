//
//  HourlyForecastComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct HourlyForecastComponent: View {
    
    // MARK: - Properties
    let temperature: Int
    let icon: UIImage?
    let hour: String
    var imageDescription: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            TemperatureVerticalBarComponent(temperature: temperature)
            
            Text("\(hour)")
                .font(.caption)
            
            WeatherIconComponent(icon: icon,
                                 size: 35,
                                 imageDescription: imageDescription)
        }
    }
}

#if DEBUG

struct HourlyForecastComponent_Previews: PreviewProvider {
    static var previews: some View {
        HourlyForecastComponent(temperature: 40,
                                icon: R.image.icn_weather_clouds_day(),
                                hour: "23:00",
                                imageDescription: "cloud")
    }
}

#endif
