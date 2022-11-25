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
}

class WeatherViewModel {
    
    struct WeatherData {
        let name: String
        let temp: Double
        let icon: String
        
    }
    
    var weatherData: WeatherData?
    
    weak var delegate: WeatherViewModelDelegate?
    
    func getWeatherByCity(city: String) {
        networkWeatherManager.fetchCurrentWeather(forCity: city) { result in
            switch result {
            case .failure:
                print("failure")
            case .success(let weather):
                print("success")
                if let name = weather.name, let temp = weather.main?.temp, let icon =
                    weather.weather?.first?.icon {
                    self.weatherData = WeatherData(name: name, temp: temp, icon: icon)
                    DispatchQueue.main.async {
                        self.delegate?.reloadData()
                    }
                }
            }
        }
    }
}
