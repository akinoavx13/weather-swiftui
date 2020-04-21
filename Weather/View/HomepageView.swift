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
        let lastUpdate: Date
        let error: WeatheryError?
        let locality: String
        let latitude: Double
        let longitude: Double
        let precipitationAccumulation: Float
        let precipitationIntensity: Float
        let precipitationProbability: Float
        let precipitationType: String
        let pressure: Float
    }
    
    // MARK: - Properties
    @State private var showInformationModel = false
    
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
              dailyForecasts: Array(state.weatherState.forecast?.daily.data.prefix(7) ?? []),
              lastUpdate: state.weatherState.lastUpdate,
              error: state.error,
              locality: state.locationState.locality,
              latitude: state.weatherState.forecast?.latitude ?? 0,
              longitude: state.weatherState.forecast?.longitude ?? 0,
              precipitationAccumulation: state.weatherState.forecast?.currently.precipAccumulation ?? 0,
              precipitationIntensity: state.weatherState.forecast?.currently.precipIntensity ?? 0,
              precipitationProbability: state.weatherState.forecast?.currently.precipProbability ?? 0,
              precipitationType: state.weatherState.forecast?.currently.precipType ?? R.string.localizable.unknown(),
              pressure: state.weatherState.forecast?.currently.pressure ?? 0)
    }
    
    // MARK: - Body
    func body(props: Props) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                if props.isLoading {
                    LoadingComponent()
                } else {
                    if props.error == nil {
                        LocalityComponent(showInformationModal: $showInformationModel,
                                          locality: props.locality)
                        
                        CurrentForecastComponent(temperature: props.temperature,
                                                 feelingTemperature: props.feelingTemperature,
                                                 icon: props.currentForecastIcon,
                                                 imageDescription: props.currentForecastDescription)
                        
                        NextForecastComponent(hours: Int(Date().format(format: "HH")) ?? 0,
                                              summary: props.nextForecastSummary,
                                              hourlyForecasts: props.hourlyForecasts)
                        
                        WeekForecastComponent(summary: props.weekForecastSummary,
                                              dailyForecasts: props.dailyForecasts)
                    } else {
                        ErrorComponent(message: props.error!.customMessage)
                    }
                    
                    Spacer()
                    
                    ReloadButtonComponent(lastUpdate: props.lastUpdate)
                    
                    AppInformationComponent()
                }
            }
            .sheet(isPresented: $showInformationModel) {
                InformationModelView(latitude: props.latitude,
                                     longitude: props.longitude,
                                     precipitationAccumulation: props.precipitationAccumulation,
                                     precipitationIntensity: props.precipitationIntensity,
                                     precipitationProbability: props.precipitationProbability,
                                     precipitationType: props.precipitationType,
                                     pressure: props.pressure)
            }
        }
        .padding()
        .onAppear {
            store.dispatch(action: WeatherAction.FetchForecast())
        }

        .alert(isPresented: .constant(props.error != nil)) {
            Alert(title: Text(props.error!.customTitle),
                  message: Text(props.error!.customMessage),
                  dismissButton: .default(Text(props.error!.actionTitle)))
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
