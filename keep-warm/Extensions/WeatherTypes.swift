//
//  weatherTypes.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 25.11.2022.
//

import Foundation

var icon: String = "clear sky.png"

enum WeatherTypes {
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
    
    var value: String {
        switch self {
        case .clearSky:
            return "clear sky.png"
        case .fewClouds:
            return "few clouds.png"
        case .scatteredClouds:
            return "scattered clouds.png"
        case .brokenClouds:
            return "scattered clouds.png"
        case .showerRain:
            return "shower rain.png"
        case .rain:
            return "rain.png"
        case .thunderstorm:
            return "thunderstorm.png"
        case .snow:
            return "snow.png"
        case .mist:
            return "mist.png"
        }
    }
}
