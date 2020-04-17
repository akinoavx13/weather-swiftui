//
//  NextForecastComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct NextForecastComponent: View {
    
    // MARK: - Properties
    var hours: Int
    var summary: String
    var hourlyForecasts: [DataForecast]
    
    private var title: String {
        if hours >= 0 && hours <= 6 || hours >= 23 && hours <= 24 {
            return R.string.localizable.this_night()
        } else if hours >= 7 && hours <= 11 {
            return R.string.localizable.this_morning()
        } else if hours >= 12 && hours <= 18 {
            return R.string.localizable.this_afternoon()
        } else if hours >= 19 && hours <= 22 {
            return R.string.localizable.tonight()
        }
        
        return ""
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleComponent(title: title,
                                  subtitle: "\(R.string.localizable.forecast_summary()) \(summary)")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom, spacing: 8) {
                    ForEach(hourlyForecasts) { forecast in
                        HourlyForecastComponent(temperature: Int(forecast.temperature ?? 0),
                                                icon: forecast.imageIcon,
                                                hour: forecast.date.format(format: "H:ss"),
                                                imageDescription: forecast.iconDescription)
                    }
                }
            }
        }
    }
}

struct NextForecastComponent_Previews: PreviewProvider {
    static var previews: some View {
        NextForecastComponent(hours: 7,
                              summary: "Clear skies all day.",
                              hourlyForecasts: DataForecast.list)
    }
}
