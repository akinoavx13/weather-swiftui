//
//  View+SectionStyle.swift
//  Weather
//
//  Created by Maxime Maheo on 21/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

extension View {
    
    func sectionStyle() -> some View {
        self.padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
            .padding()
    }
    
}

#if DEBUG

struct SectionStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("View+SectionStyle.swift")
        }
        .sectionStyle()
    }
}

#endif
