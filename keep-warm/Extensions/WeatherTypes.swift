//
//  weatherTypes.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 25.11.2022.
//

import Foundation

var icon: String = "clear sky.png"

enum WeatherTypes: CaseIterable {
    case thunderstorm
    case clearSky
    case clouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case snow
    case mist
    
    var value: String {
        switch self {
        case .clearSky:
            return "clear sky.png"
        case .clouds:
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
    
    var code: Int {
        switch self {
        case .thunderstorm:
            return 200
        case .clouds:
            return 800
        //default: return 0
        case .clearSky:
            return 0
        case .scatteredClouds:
            return 0
        case .brokenClouds:
            return 0
        case .showerRain:
            return 0
        case .rain:
            return 0
        case .snow:
            return 0
        case .mist:
            return 0
        }
        
    }
    
}
