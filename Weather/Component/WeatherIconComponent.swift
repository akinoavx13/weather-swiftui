//
//  WeatherIconComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 15/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.WeatherIconComponent
//

import SwiftUI

struct WeatherIconComponent: View {
    
    // MARK: - Properties
    var icon: UIImage?
    var size: CGFloat
    var imageDescription: String
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size, height: size)
                .foregroundColor(.midnightBlue)
            
            if icon != nil {
                Image(uiImage: icon!)
                    .resizable()
                    .frame(width: size * 0.7, height: size * 0.7)
            }
        }
        .accessibility(label: Text(imageDescription))
    }
}

#if DEBUG

struct WeatherIconComponent_Previews: PreviewProvider {
    static var previews: some View {
        WeatherIconComponent(icon: R.image.icn_weather_rain(),
                             size: 70,
                             imageDescription: "cloud")
    }
}

#endif
