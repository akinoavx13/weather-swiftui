//
//  InformationModelView.swift
//  Weather
//
//  Created by Maxime Maheo on 21/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct InformationModelView: View {
    
    // MARK: - Properties
    var latitude: Double
    var longitude: Double
    var precipitationAccumulation: Float
    var precipitationIntensity: Float
    var precipitationProbability: Float
    var precipitationType: String
    var pressure: Float
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.more_information())
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Coordinates")
                    .font(.caption)
                
                MoreInformationRowComponent(title: "Latitude",
                                            value: "\(latitude)")
                
                MoreInformationRowComponent(title: "Longitude",
                                            value: "\(longitude)")
            }
            .sectionStyle()
            
            VStack(alignment: .leading) {
                Text("Precipitation")
                    .font(.caption)
                
                MoreInformationRowComponent(title: "Accumulation",
                                            value: "\(precipitationAccumulation * 10) mm")
                
                MoreInformationRowComponent(title: "Intensity",
                                            value: "\(precipitationIntensity) mm/h")
                
                MoreInformationRowComponent(title: "Probability",
                                            value: "\(precipitationProbability * 100) %")
                
                MoreInformationRowComponent(title: "Type",
                                            value: precipitationType)
            }
            .sectionStyle()
            
            MoreInformationRowComponent(title: "Pressure",
                                        value: "\(pressure) hPa")
                .sectionStyle()
            
            Spacer()
        }
    }
}

#if DEBUG

struct InformationModelView_Previews: PreviewProvider {
    static var previews: some View {
        InformationModelView(latitude: 0.2345,
                             longitude: 0.5672,
                             precipitationAccumulation: 0.234,
                             precipitationIntensity: 0.235,
                             precipitationProbability: 0.876,
                             precipitationType: "type",
                             pressure: 1004)
    }
}

#endif
