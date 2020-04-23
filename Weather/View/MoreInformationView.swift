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
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                makeCoordinatesView()
                
                makePrecipitationView()
                
                makePressureView()

                if sunrise != nil || sunset != nil {
                    makeSunriseSunsetView()
                }
                
                Spacer()
            }
            .navigationBarTitle(Text(R.string.localizable.more_information()))
        }
    }
}

extension MoreInformationView {
    
    private func makeSectionTitle(title: String) -> some View {
        Text(title)
            .font(.caption)
            .padding(.bottom, 8)
    }
    
    private func makeCoordinatesView() -> some View {
        VStack(alignment: .leading) {
            makeSectionTitle(title: R.string.localizable.coordinates())
            
            MoreInformationRowComponent(title: R.string.localizable.latitude(),
                                        value: "\(latitude)")
            
            MoreInformationRowComponent(title: R.string.localizable.longitude(),
                                        value: "\(longitude)")
        }
        .sectionStyle()
    }
    
    private func makePrecipitationView() -> some View {
        VStack(alignment: .leading) {
            makeSectionTitle(title: R.string.localizable.precipication())
            
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
    
    private func makePressureView() -> some View {
        MoreInformationRowComponent(title: R.string.localizable.pressure(),
                                value: "\(pressure) hPa")
        .sectionStyle()
    }
    
    private func makeSunriseSunsetView() -> some View {
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
}

#if DEBUG

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
                             sunset: Date(timeIntervalSince1970: 255650764))
    }
}

#endif
