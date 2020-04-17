//
//  Locale+Language.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

extension Locale {
    
    static var preferredLocale: Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        
        return Locale(identifier: preferredIdentifier)
    }
    
    static var language: String {
        let languageIdentifier = Locale.preferredLanguages.first ?? "en-US"
        let languageDic = Locale.components(fromIdentifier: languageIdentifier)
        
        return languageDic["kCFLocaleLanguageCodeKey"] ?? "en"
    }
    
}
