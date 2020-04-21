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
    @Binding var showInformationModal: Bool
    var locality: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            
            HStack {
                Text(locality)
                    .font(.headline)
                    .foregroundColor(.sunFlower)
                
                Spacer()
                
                Button(action: {
                    self.showInformationModal.toggle()
                }, label: {
                    Image(systemName: "info.circle")
                        .foregroundColor(.sunFlower)
                })
            }
            
            Rectangle()
                .fill(Color.sunFlower)
                .frame(height: 2)
        }
    }
}

struct LocalityComponent_Previews: PreviewProvider {
    static var previews: some View {
        LocalityComponent(showInformationModal: .constant(false),
                          locality: "Bordeaux, France")
    }
}
