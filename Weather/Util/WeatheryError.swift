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
            return R.string.localizable.generic_error_title()
        case .locationError:
            return R.string.localizable.location_error_title()
        }
    }
    
    var customMessage: String {
        switch self {
        case .generic:
            return R.string.localizable.generic_error_message()
        case .locationError:
            return R.string.localizable.location_error_message()
        }
    }

    var actionTitle: String {
        R.string.localizable.error_action_title()
    }
    
    // MARK: - Lifecycle
    init(error: Error) {
        if let locationError = error as? LocationServiceError {
            switch locationError {
            case .locationServicesNotEnabled, .noLocation:
                self = .locationError
            case .selfIsNil:
                self = .generic
            }
        } else {
            self = .generic
        }
    }
    
}
