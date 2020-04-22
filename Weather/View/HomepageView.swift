//
//  HomepageView.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct HomepageView: View {

    // MARK: - Properties
    @EnvironmentObject private var weatherViewModel: WeatherViewModel
    @EnvironmentObject private var locationViewModel: LocationViewModel
    
    @State private var showInformationModel = false
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                if weatherViewModel.isLoading {
                    LoadingComponent()
                } else {
                    if weatherViewModel.error == nil {
                        if locationViewModel.error == nil {
                            LocalityComponent(showInformationModal: $showInformationModel,
                                              locality: locationViewModel.locality)
                        }
                        
                        CurrentForecastComponent(temperature: Int(weatherViewModel.forecast?.currently.temperature ?? 0),
                                                 feelingTemperature: Int(weatherViewModel.forecast?.currently.apparentTemperature ?? 0),
                                                 icon: weatherViewModel.forecast?.currently.imageIcon,
                                                 imageDescription: weatherViewModel.forecast?.currently.icon ?? "")
                        
                        NextForecastComponent(summary: weatherViewModel.forecast?.hourly.summary ?? "",
                                              hourlyForecasts: weatherViewModel.forecast?.hourly.data ?? [])

                        WeekForecastComponent(summary: weatherViewModel.forecast?.daily.summary ?? "",
                                              dailyForecasts: Array(weatherViewModel.forecast?.daily.data.prefix(7) ?? []))
                    }
                    
                    Spacer()

                    ReloadButtonComponent(lastUpdate: weatherViewModel.lastUpdate)

                    AppInformationComponent()
                }
            }
        }
        .padding()
        .onAppear {
            self.weatherViewModel.fetchForecast()
            self.locationViewModel.fetchLocality()
        }
        .sheet(isPresented: $showInformationModel) {
            InformationModelView(latitude: self.weatherViewModel.forecast?.latitude ?? 0,
                                 longitude: self.weatherViewModel.forecast?.longitude ?? 0,
                                 precipitationAccumulation: self.weatherViewModel.forecast?.currently.precipAccumulation ?? 0,
                                 precipitationIntensity: self.weatherViewModel.forecast?.currently.precipIntensity ?? 0,
                                 precipitationProbability: self.weatherViewModel.forecast?.currently.precipProbability ?? 0,
                                 precipitationType: self.weatherViewModel.forecast?.currently.precipType ?? "",
                                 pressure: self.weatherViewModel.forecast?.currently.pressure ?? 0)
        }
        .alert(isPresented: .constant(weatherViewModel.error != nil)) {
            Alert(title: Text(weatherViewModel.error!.customTitle),
                  message: Text(weatherViewModel.error!.customMessage),
                  dismissButton: .default(Text(weatherViewModel.error!.actionTitle)))
        }
    }
}

#if DEBUG

struct HomepageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomepageView()
                .environmentObject(WeatherViewModel())
                .environmentObject(LocationViewModel())
            
            HomepageView()
                .environmentObject(WeatherViewModel())
                .environmentObject(LocationViewModel())
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
        }
    }
}

#endif
