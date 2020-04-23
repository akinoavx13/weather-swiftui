//
//  MoreInformationRowComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 21/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct MoreInformationRowComponent: View {
    
    // MARK: - Properties
    var title: String
    var value: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Text(value)
        }
        .padding(.vertical, 4)
    }
}

struct MoreInformationRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationRowComponent(title: "Title",
                                    value: "Content")
    }
}
