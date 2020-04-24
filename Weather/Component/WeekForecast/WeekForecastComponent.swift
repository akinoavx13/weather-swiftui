//
//  WeekForecastComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct WeekForecastComponent: View {
    
    // MARK: - Properties
    var summary: String
    var dailyForecasts: [DataForecast]
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            SectionTitleComponent(title: R.string.localizable.this_week(),
                                  subtitle: summary)
            
            VStack(alignment: .leading, spacing: 8) {
                            ForEach(dailyForecasts) { forecast in
                                DailyForecastComponent(date: forecast.date,
                                                       temperatureMin: Int(forecast.temperatureMin ?? 0),
                                                       temperatureMax: Int(forecast.temperatureMax ?? 0),
                                                       precipitationProbability: forecast.precipProbability,
                                                       icon: forecast.imageIcon,
                                                       imageDescription: forecast.iconDescription)
                            }
                        }
        }
    }
}

struct WeekForecastComponent_Previews: PreviewProvider {
    static var previews: some View {
        WeekForecastComponent(summary: "Light rain Friday until next Tuesday.",
                              dailyForecasts: DataForecast.list)
    }
}
