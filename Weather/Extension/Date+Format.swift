//
//  TimeInterval+Format.swift
//  Weather
//
//  Created by Maxime Maheo on 14/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension Date {
    func format(format: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.preferredLocale
        
        if format != nil {
            dateFormatter.dateFormat = format
        } else {
            dateFormatter.dateStyle = .medium
        }

        return dateFormatter.string(from: self)
    }
}
