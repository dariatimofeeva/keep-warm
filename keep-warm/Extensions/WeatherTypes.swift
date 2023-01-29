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
//    case scatteredClouds
//    case brokenClouds
    case drizzle
    case rain
    case snow
//    case mist
    
    var value: String {
        switch self {
        case .clearSky:
            return "clear sky.png"
        case .clouds:
            return "few clouds.png"
//        case .scatteredClouds:
//            return "scattered clouds.png"
//        case .brokenClouds:
//            return "scattered clouds.png"
        case .drizzle:
            return "shower rain.png"
        case .rain:
            return "rain.png"
        case .thunderstorm:
            return "thunderstorm.png"
        case .snow:
            return "snow.png"
//        case .mist:
//            return "mist.png"
        }
    }
    
    var code: ClosedRange<Int> {
        switch self {
        case .thunderstorm:
            return 200...232
        case .clouds:
            return 801...804
        //default: return 0
        case .clearSky:
            return 800...800
//        case .scatteredClouds:
//            return 0
//        case .brokenClouds:
//            return 0
        case .drizzle:
            return 300...321
        case .rain:
            return 500...531
        case .snow:
            return 600...622
//        case .mist:
//            return 0
        }
        
    }
    
    static func getWeatherType(by id: Int) -> WeatherTypes? {
        for type in WeatherTypes.allCases {
            if type.code.lowerBound <= id, type.code.upperBound >= id {
                return type
            }
        }
        return nil
    }
    
}
