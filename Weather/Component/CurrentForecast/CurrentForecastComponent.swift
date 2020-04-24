//
//  CurrentForecastComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct CurrentForecastComponent: View {
    
    // MARK: - Properties
    var temperature: Int
    var feelingTemperature: Int
    var icon: UIImage?
    var imageDescription: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            SectionTitleComponent(title: R.string.localizable.currently(),
                                  subtitle: R.string.localizable.forecast_for_the_next_hour())
            
            HStack(alignment: .center) {
                WeatherIconComponent(icon: icon,
                                     size: 100,
                                     imageDescription: imageDescription)
                
                VStack(alignment: .leading) {
                    Text("\(temperature)°")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("\(R.string.localizable.feeling()) \(feelingTemperature)°")
                        .font(.headline)
                }
            }
        }
    }
}

struct CurrentForecastComponent_Previews: PreviewProvider {
    static var previews: some View {
        CurrentForecastComponent(temperature: 22,
                                 feelingTemperature: 18,
                                 icon: R.image.icn_weather_clouds_night(),
                                 imageDescription: "sun")
    }
}
