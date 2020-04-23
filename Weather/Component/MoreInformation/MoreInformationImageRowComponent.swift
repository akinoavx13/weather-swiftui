//
//  MoreInformationImageRowComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 23/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct MoreInformationImageRowComponent: View {
    
    // MARK: - Properties
    var title: String
    var description: String
    var image: UIImage?
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            
            Spacer()

            if image == nil {
                Text(description)
            } else {
                WeatherIconComponent(icon: image!,
                                     size: 35,
                                     imageDescription: description)
            }
        }
    }
}

struct MoreInformationImageRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationImageRowComponent(title: "Type",
                                         description: "description",
                                         image: R.image.icn_weather_rain())
    }
}
