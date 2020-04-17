//
//  Color.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import SwiftUI

extension Color {
    static let midnightBlue = Color(red: 10 / 255, green: 61 / 255, blue: 98 / 255)
    static let sunFlower = Color(red: 241 / 255, green: 196 / 255, blue: 15 / 255)
    static let sunFlowerDarker = Color(red: 221 / 255, green: 186 / 255, blue: 15 / 255)
    static let electronblue = Color(red: 130 / 255, green: 204 / 255, blue: 221 / 255)

    static var backgroundColorIcon: Color {
        guard let hour = Int(Date().format(format: "HH")) else { return .midnightBlue }

        return hour >= 8 && hour <= 20 ? .electronblue : .midnightBlue
    }
}
