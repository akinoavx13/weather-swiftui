//
//  LocalityComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 20/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct LocalityComponent: View {
    
    // MARK: - Properties
    var locality: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(locality)
                .font(.headline)
                .foregroundColor(.sunFlower)
            
            Rectangle()
                .fill(Color.sunFlower)
                .frame(height: 2)
        }
    }
}

struct LocalityComponent_Previews: PreviewProvider {
    static var previews: some View {
        LocalityComponent(locality: "Bordeaux, France")
    }
}
