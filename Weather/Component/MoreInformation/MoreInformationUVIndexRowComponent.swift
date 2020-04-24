//
//  MoreInformationUVIndexRowComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 24/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct MoreInformationUVIndexRowComponent: View {
    
    // MARK: - Properties
    var uvIndex: Int
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(R.string.localizable.uv_index())
                .font(.headline)
            
            Spacer()

            makeUVIndexComponent()
        }
    }
}

extension MoreInformationUVIndexRowComponent {
    
    private func makeUVIndexComponent() -> some View {
        var backgroundColor: Color
        
        if uvIndex >= 0 && uvIndex <= 2 {
            backgroundColor = .green
        } else if uvIndex >= 3 && uvIndex <= 4 {
            backgroundColor = .yellow
        } else if uvIndex >= 5 && uvIndex <= 6 {
           backgroundColor = .orange
        } else if uvIndex >= 7 && uvIndex <= 8 {
            backgroundColor = .red
        } else {
            backgroundColor = .purple
        }
        
        return Text("\(uvIndex)")
            .padding(4)
            .background(backgroundColor)
            .cornerRadius(4)
    }
    
}

struct MoreInformationUVIndexRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationUVIndexRowComponent(uvIndex: 4)
    }
}
