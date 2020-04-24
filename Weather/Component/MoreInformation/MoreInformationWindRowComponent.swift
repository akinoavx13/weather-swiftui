//
//  MoreInformationWindRowComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 24/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct MoreInformationWindRowComponent: View {
    
    // MARK: - Properties
    var speed: Float
    var bearing: Double
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(R.string.localizable.wind_speed())
                .font(.headline)
            
            Spacer()

            ZStack {
                Circle()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.midnightBlue)
                
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.white)
            }
            .rotationEffect(.degrees(bearing))

            Text("\(speed, specifier: "%.2f") m/s")
        }
    }
}

struct MoreInformationWindRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationWindRowComponent(speed: 4.2356,
                                        bearing: 325)
    }
}
