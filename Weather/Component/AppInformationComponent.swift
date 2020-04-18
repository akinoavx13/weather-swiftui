//
//  AppInformationComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 18/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct AppInformationComponent: View {
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Text(R.string.localizable.made_by("Maxime Maheo"))
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text(R.string.localizable.data_provider())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

#if DEBUG

struct AppInformationComponent_Previews: PreviewProvider {
    static var previews: some View {
        AppInformationComponent()
    }
}

#endif
