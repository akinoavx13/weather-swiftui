//
//  WeatheryError.swift
//  Weather
//
//  Created by Maxime Maheo on 19/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

enum WeatheryError: LocalizedError {
    
    case generic, locationError
    
    // MARK: - Properties
    var customTitle: String {
        switch self {
        case .generic:
            return "§Generic title"
        case .locationError:
            return "§Location title"
        }
    }
    
    var customMessage: String {
        switch self {
        case .generic:
            return "§Generic message"
        case .locationError:
            return "§Location service message"
        }
    }

    var actionTitle: String {
        "§Got it !"
    }
    
    // MARK: - Lifecycle
    init(error: Error) {
        if let locationError = error as? LocationServiceError {
            switch locationError {
            case .locationServicesNotEnabled:
                self = .locationError
            case .selfIsNil:
                self = .generic
            }
        } else {
            self = .generic
        }
    }
    
}
