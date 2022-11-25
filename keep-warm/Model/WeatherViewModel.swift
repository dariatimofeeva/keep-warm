//
//  WeatherViewModel.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 23.10.2022.
//

import Foundation
// TODO: получить погоду
// TODO: сохранить ответ
// TODO: делегат weatherViewModel и weatherVC

let networkWeatherManager = NetworkWeatherManager()

protocol WeatherViewModelDelegate: AnyObject {
    func reloadData()
    func updateIcon()
}

class WeatherViewModel {
    
    struct WeatherData {
        let name: String
        let temp: Double
        let id: Int
        var icon: String = ""
    }
    
    var weatherData: WeatherData? {
        didSet {
            setWeatherIcon()
        }
        
    }
    
    weak var delegate: WeatherViewModelDelegate?
    
    func getWeatherByCity(city: String) {
        networkWeatherManager.fetchCurrentWeather(forCity: city) { result in
            switch result {
            case .failure:
                print("failure")
            case .success(let weather):
                print("success")
                if let name = weather.name, let temp = weather.main?.temp, let id = weather.weather?.first?.id {
                    self.weatherData = WeatherData(name: name, temp: temp, id: id)
                    DispatchQueue.main.async {
                        self.delegate?.reloadData()
                    }
                }
            }
        }
    }
    
    private func setWeatherIcon() {
        for type in WeatherTypes.allCases {
            if let id = weatherData?.id, id >= type.code, id - type.code < 100 {
                weatherData?.icon = type.value
                delegate?.updateIcon()
            }
        }
    }
}
