//
//  SectionTitleComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct SectionTitleComponent: View {
    
    // MARK: - Properties
    var title: String
    var subtitle: String
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .accessibility(addTraits: .isHeader)
            
            Text(subtitle)
                .font(.caption)
        }
        .padding(.bottom, 8)
    }
}

struct SectionTitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        SectionTitleComponent(title: "Title",
                              subtitle: "Subtitle")
    }
}
