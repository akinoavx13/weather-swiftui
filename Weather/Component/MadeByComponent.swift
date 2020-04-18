//
//  MadeByComponent.swift
//  Weather
//
//  Created by Maxime Maheo on 18/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

struct MadeByComponent: View {
    var body: some View {
        HStack {
            Spacer()
            
            Text(R.string.localizable.made_by("Maxime Maheo"))
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
        }
    }
}

#if DEBUG

struct MadeByComponent_Previews: PreviewProvider {
    static var previews: some View {
        MadeByComponent()
    }
}

#endif
