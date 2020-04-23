//
//  Forecast.swift
//  Weather
//
//  Created by Maxime Maheo on 13/04/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import UIKit

struct Forecast: Codable {
    
    let currently: DataForecast
    let hourly: DataForecasts
    let daily: DataForecasts
    let latitude: Double
    let longitude: Double
    
}

struct DataForecasts: Codable {
    let summary: String
    let icon: String
    let data: [DataForecast]
}

struct DataForecast: Codable, Identifiable {
    let id = UUID()
    let apparentTemperature: Float?
    let cloudCover: Float
    let humidity: Float
    let icon: String
    var precipAccumulation: Float?
    let precipIntensity: Float
    let precipProbability: Float
    let precipType: String?
    let pressure: Float
    let summary: String
    var sunriseTime: TimeInterval?
    var sunsetTime: TimeInterval?
    var temperature: Float?
    var temperatureMax: Float?
    var temperatureMin: Float?
    let time: TimeInterval
    let uvIndex: Int
    let visibility: Float
    let windSpeed: Float
    let windBearing: Float
    
    var date: Date {
        Date(timeIntervalSince1970: time)
    }
    
    var sunriseDate: Date? {
        if let sunriseTime = sunriseTime {
            return Date(timeIntervalSince1970: sunriseTime)
        }
        return nil
    }
    
    var sunsetDate: Date? {
        if let sunsetTime = sunsetTime {
            return Date(timeIntervalSince1970: sunsetTime)
        }
        return nil
    }
    
    var precipTypeIcon: UIImage? {
        if precipType == "rain" {
            return R.image.icn_weather_rain()
        } else if precipType == "snow" {
            return R.image.icn_weather_snow()
        } else if precipType == "sleet" {
            return R.image.icn_weather_sleet()
        }
        
        return nil
    }
    
    var imageIcon: UIImage? {
        if icon == "clear-day" {
            return R.image.icn_weather_sun()
        } else if icon == "clear-night" {
            return R.image.icn_weather_moon()
        } else if icon == "rain" {
            return R.image.icn_weather_rain()
        } else if icon == "snow" {
            return R.image.icn_weather_snow()
        } else if icon == "sleet" {
            return R.image.icn_weather_sleet()
        } else if icon == "wind" {
            return R.image.icn_weather_wind()
        } else if icon == "fog" {
            return R.image.icn_weather_fog()
        } else if icon == "cloudy" {
            return R.image.icn_weather_broken_clouds()
        } else if icon == "partly-cloudy-day" {
            return R.image.icn_weather_clouds_day()
        } else if icon == "partly-cloudy-night" {
            return R.image.icn_weather_clouds_night()
        } else if icon == "hail" {
            return R.image.icn_weather_hail()
        } else if icon == "thunderstorm" {
            return R.image.icn_weather_thunderstorm()
        } else if icon == "tornado" {
            return R.image.icn_weather_tornado()
        }
        
        return nil
    }
    
    var iconDescription: String {
        if icon == "clear-day" {
            return R.string.localizable.clear_day()
        } else if icon == "clear-night" {
            return R.string.localizable.clear_night()
        } else if icon == "rain" {
            return R.string.localizable.rain()
        } else if icon == "snow" {
            return R.string.localizable.snow()
        } else if icon == "sleet" {
            return R.string.localizable.sleet()
        } else if icon == "wind" {
            return R.string.localizable.wind()
        } else if icon == "fog" {
            return R.string.localizable.fog()
        } else if icon == "cloudy" {
            return R.string.localizable.cloudy()
        } else if icon == "partly-cloudy-day" {
            return R.string.localizable.partly_cloudy_day()
        } else if icon == "partly-cloudy-night" {
            return R.string.localizable.partly_cloudy_night()
        } else if icon == "hail" {
            return R.string.localizable.hail()
        } else if icon == "thunderstorm" {
            return R.string.localizable.thunderstorm()
        } else if icon == "tornado" {
            return R.string.localizable.tornado()
        }
        
        return ""
    }
}

#if DEBUG

extension DataForecast {
    static let one = DataForecast(apparentTemperature: 14.68,
                                  cloudCover: 0.99,
                                  humidity: 0.68,
                                  icon: "cloudy",
                                  precipAccumulation: nil,
                                  precipIntensity: 0.0266,
                                  precipProbability: 0.03,
                                  precipType: "rain",
                                  pressure: 1014.1,
                                  summary: "Ciel Couvert",
                                  sunriseTime: nil,
                                  sunsetTime: nil,
                                  temperature: 74.68,
                                  temperatureMax: nil,
                                  temperatureMin: nil,
                                  time: 1586815200,
                                  uvIndex: 0,
                                  visibility: 16.093,
                                  windSpeed: 2.97,
                                  windBearing: 126)
    
    static let list: [DataForecast] = [
        DataForecast(apparentTemperature: 14.68,
                     cloudCover: 0.99,
                     humidity: 0.68,
                     icon: "cloudy",
                     precipAccumulation: nil,
                     precipIntensity: 0.0266,
                     precipProbability: 0.03,
                     precipType: "rain",
                     pressure: 1014.1,
                     summary: "Ciel Couvert",
                     sunriseTime: nil,
                     sunsetTime: nil,
                     temperature: 76.68,
                     temperatureMax: 94.38,
                     temperatureMin: 54.38,
                     time: 1586815200,
                     uvIndex: 0,
                     visibility: 16.093,
                     windSpeed: 2.97,
                     windBearing: 126),
        DataForecast(apparentTemperature: 14.38,
                     cloudCover: 0.99,
                     humidity: 0.69,
                     icon: "cloudy",
                     precipAccumulation: nil,
                     precipIntensity: 0.0208,
                     precipProbability: 0.03,
                     precipType: "rain",
                     pressure: 1014.6,
                     summary: "Ciel Couvert",
                     sunriseTime: nil,
                     sunsetTime: nil,
                     temperature: 74.38,
                     temperatureMax: 84.38,
                     temperatureMin: 64.38,
                     time: 1586818800,
                     uvIndex: 0,
                     visibility: 16.093,
                     windSpeed: 5.35,
                     windBearing: 113)
    ]
}

extension DataForecasts {
    
    static let one = DataForecasts(summary: "Ciel Couvert",
                                   icon: "cloudy",
                                   data: DataForecast.list)
    
}

#endif
