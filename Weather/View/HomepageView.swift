//
//  HomepageView.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct HomepageView: ConnectedView {
    
    struct Props {
        let isLoading: Bool
        let temperature: Int
        let feelingTemperature: Int
        let currentForecastIcon: UIImage?
        let currentForecastDescription: String
        let nextForecastSummary: String
        let hourlyForecasts: [DataForecast]
        let weekForecastSummary: String
        let dailyForecasts: [DataForecast]
    }
    
    // MARK: - Methods
    func map(state: AppState, dispatch: @escaping DispatchFunction) -> Props {
        Props(isLoading: state.weatherState.isLoading,
              temperature: Int(state.weatherState.forecast?.currently.temperature ?? 0),
              feelingTemperature: Int(state.weatherState.forecast?.currently.apparentTemperature ?? 0),
              currentForecastIcon: state.weatherState.forecast?.currently.imageIcon,
              currentForecastDescription: state.weatherState.forecast?.currently.icon ?? "",
              nextForecastSummary: state.weatherState.forecast?.hourly.summary ?? "",
              hourlyForecasts: state.weatherState.forecast?.hourly.data ?? [],
              weekForecastSummary: state.weatherState.forecast?.daily.summary ?? "",
              dailyForecasts: Array(state.weatherState.forecast?.daily.data.prefix(7) ?? []))
    }
    
    // MARK: - Body
    func body(props: Props) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                if props.isLoading {
                    LoadingComponent()
                }
                
                CurrentForecastComponent(temperature: props.temperature,
                                         feelingTemperature: props.feelingTemperature,
                                         icon: props.currentForecastIcon,
                                         imageDescription: props.currentForecastDescription)
                
                NextForecastComponent(hours: Int(Date().format(format: "HH")) ?? 0,
                                      summary: props.nextForecastSummary,
                                      hourlyForecasts: props.hourlyForecasts)
                
                WeekForecastComponent(summary: props.weekForecastSummary,
                                      dailyForecasts: props.dailyForecasts)
            }
        }
        .padding()
        .onAppear {
            store.dispatch(action: WeatherAction.FetchForecast())
        }
    }
}

#if DEBUG

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomepageView()
                .environmentObject(previewStore)
            
            HomepageView()
                .environmentObject(previewStore)
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
}

#endif
