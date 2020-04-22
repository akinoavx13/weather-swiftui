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
        NavigationView {
            VStack(alignment: .leading) {
                
                makeCoordinatesView()
                
                makePrecipitationView()
                
                makePressureView()

                Spacer()
            }
            .navigationBarTitle(Text(R.string.localizable.more_information()))
        }
    }
}

extension InformationModelView {
    
    private func makeCoordinatesView() -> some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.coordinates())
                .font(.caption)
            
            MoreInformationRowComponent(title: R.string.localizable.latitude(),
                                        value: "\(latitude)")
            
            MoreInformationRowComponent(title: R.string.localizable.longitude(),
                                        value: "\(longitude)")
        }
        .sectionStyle()
    }
    
    private func makePrecipitationView() -> some View {
        VStack(alignment: .leading) {
            Text(R.string.localizable.precipication())
                .font(.caption)
            
            MoreInformationRowComponent(title: R.string.localizable.accumulation(),
                                        value: "\(precipitationAccumulation * 10) mm")
            
            MoreInformationRowComponent(title: R.string.localizable.intensity(),
                                        value: "\(precipitationIntensity) mm/h")
            
            MoreInformationRowComponent(title: R.string.localizable.probability(),
                                        value: "\(precipitationProbability * 100) %")
            
            MoreInformationRowComponent(title: R.string.localizable.type(),
                                        value: precipitationType)
        }
        .sectionStyle()
    }
    
    private func makePressureView() -> some View {
        MoreInformationRowComponent(title: R.string.localizable.pressure(),
                                value: "\(pressure) hPa")
        .sectionStyle()
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
