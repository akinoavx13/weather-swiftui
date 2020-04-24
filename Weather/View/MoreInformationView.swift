//
//  MoreInformationView.swift
//  Weather
//
//  Created by Maxime Maheo on 21/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct MoreInformationView: View {
    
    // MARK: - Properties
    var latitude: Double
    var longitude: Double
    var precipitationAccumulation: Float
    var precipitationIntensity: Float
    var precipitationProbability: Float
    var precipitationType: String?
    var precipitationTypeImage: UIImage?
    var pressure: Float
    var sunrise: Date?
    var sunset: Date?
    var minimumTemperature: Int
    var maximumTemperature: Int
    var uvIndex: Int
    var visibility: Float
    var windSpeed: Float
    var windBearing: Double
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                makeCoordinatesComponent()
                
                makePrecipitationComponent()
                
                makePressureComponent()

                if sunrise != nil || sunset != nil {
                    makeSunriseSunsetComponent()
                }
                
                makeTemperatureComponent()
                
                makeUVIndexComponent()
                
                makeVisibilityComponent()
                
                makeWindComponent()
                
                Spacer()
            }
            .navigationBarTitle(Text(R.string.localizable.more_information()))
        }
    }
}

extension MoreInformationView {
    
    private func makeSectionTitleComponent(title: String) -> some View {
        Text(title)
            .font(.caption)
            .padding(.bottom, 8)
    }
    
    private func makeCoordinatesComponent() -> some View {
        VStack(alignment: .leading) {
            makeSectionTitleComponent(title: R.string.localizable.coordinates())
            
            MoreInformationRowComponent(title: R.string.localizable.latitude(),
                                        value: "\(latitude)")
            
            MoreInformationRowComponent(title: R.string.localizable.longitude(),
                                        value: "\(longitude)")
        }
        .sectionStyle()
    }
    
    private func makePrecipitationComponent() -> some View {
        VStack(alignment: .leading) {
            makeSectionTitleComponent(title: R.string.localizable.precipication())
            
            MoreInformationRowComponent(title: R.string.localizable.accumulation(),
                                        value: "\(precipitationAccumulation * 10) mm")
            
            MoreInformationRowComponent(title: R.string.localizable.intensity(),
                                        value: "\(precipitationIntensity) mm/h")
            
            MoreInformationRowComponent(title: R.string.localizable.probability(),
                                        value: "\(precipitationProbability * 100) %")
            
            Unwrap(precipitationType) {
                MoreInformationImageRowComponent(title: R.string.localizable.type(),
                                                 description: $0,
                                                 image: self.precipitationTypeImage)
            }
        }
        .sectionStyle()
    }
    
    private func makePressureComponent() -> some View {
        MoreInformationRowComponent(title: R.string.localizable.pressure(),
                                value: "\(pressure) hPa")
        .sectionStyle()
    }
    
    private func makeSunriseSunsetComponent() -> some View {
        VStack(alignment: .leading) {
            Unwrap(sunrise) {
                MoreInformationRowComponent(title: R.string.localizable.sunrise(),
                                            value: "\($0.format(format: "HH:MM"))")
            }
            
            Unwrap(sunset) {
                MoreInformationRowComponent(title: R.string.localizable.sunset(),
                                            value: "\($0.format(format: "HH:MM"))")
            }
        }
        .sectionStyle()
    }
    
    private func makeTemperatureComponent() -> some View {
        VStack(alignment: .leading) {
            makeSectionTitleComponent(title: R.string.localizable.temperatures())
            
            MoreInformationRowComponent(title: R.string.localizable.minimum_temperature(),
                                        value: "\(minimumTemperature) °")
            
            MoreInformationRowComponent(title: R.string.localizable.maximum_temperature(),
                                        value: "\(maximumTemperature) °")
        }
        .sectionStyle()
    }
    
    private func makeUVIndexComponent() -> some View {
        MoreInformationUVIndexRowComponent(uvIndex: uvIndex)
            .sectionStyle()
    }
    
    private func makeVisibilityComponent() -> some View {
        MoreInformationRowComponent(title: R.string.localizable.visibility(),
                                    value: "\(visibility) km")
            .sectionStyle()
    }
    
    private func makeWindComponent() -> some View {
        MoreInformationWindRowComponent(speed: windSpeed,
                                        bearing: windBearing)
            .sectionStyle()
    }
    
}

struct MoreInformationView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationView(latitude: 0.2345,
                             longitude: 0.5672,
                             precipitationAccumulation: 0.234,
                             precipitationIntensity: 0.235,
                             precipitationProbability: 0.876,
                             precipitationType: "type",
                             precipitationTypeImage: R.image.icn_weather_rain(),
                             pressure: 1004,
                             sunrise: Date(timeIntervalSince1970: 255613996),
                             sunset: Date(timeIntervalSince1970: 255650764),
                             minimumTemperature: 12,
                             maximumTemperature: 25,
                             uvIndex: 4,
                             visibility: 12,
                             windSpeed: 12,
                             windBearing: 235)
    }
}
