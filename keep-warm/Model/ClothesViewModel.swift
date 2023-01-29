//
//  ClothesViewModel.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 18.12.2022.
//

import Foundation

enum WeatherClothesType {
    case winter
    case coldDemi
    case warmDemi
    case summer
}
                                

class ClothesViewModel {
    
    var currentWeather: WeatherClothesType
    
    var clothes: [WeatherClothesType : [String]] = [:]
    
    var clothesForCurrentWeather: [String] {
        return clothes[currentWeather] ?? []
    }
   
    
    // TODO: есть ли возможность добавить в массив все файлы из папки, а не вносить вручную?
    
    private var clothesForWinter = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg, 9.jpg, 10.jpg"]
    private var clothesForWarmDemi = ["11.jpg", "12.jpg", "13.jpg", "14.jpg", "15.jpg", "16.jpg", "17.jpg"]
    private var clothesForColdDemi = ["18.jpg", "19.jpg", "20.jpg", "21.jpg", "22.jpg", "23.jpg", "24.jpg", "25.jpg", "26.jpg", "27.jpg"]
    private var clothesForSummer = ["28.jpg", "29.jpg", "30.jpg", "31.jpg", "32.jpg", "33.jpg", "34.jpg", "35.jpg", "36.jpg", "37.jpg", "38.jpg","39.jpg"]
    
    init(currentWeather: WeatherClothesType) {
        clothes[.winter] = clothesForWinter
        clothes[.coldDemi] = clothesForColdDemi
        clothes[.warmDemi] = clothesForWarmDemi
        clothes[.summer] = clothesForSummer
        self.currentWeather = currentWeather
    }
    
}
