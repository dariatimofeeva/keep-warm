//
//  WeatherViewModel.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 23.10.2022.
//

import Foundation

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
    
    var networkWeatherManager: INetworkManager = NetworkWeatherManager()
    
    var currentWeatherType: WeatherClothesType?
    
    var weatherData: WeatherData?
    
    weak var delegate: WeatherViewModelDelegate?
    
    func getWeatherByCity(city: String) {
        networkWeatherManager.fetchCurrentWeather(forCity: city) { [weak self] result in
            switch result {
            case .failure:
                print("failure")
            case .success(let weather):
                print("success")
                // TODO: Добавить тост с отображением информации, что город не найден. Убрать по таймеру через 4 секунды
                if let name = weather.name, let temp = weather.main?.temp, let id = weather.weather?.first?.id {
                    self?.weatherData = WeatherData(name: name, temp: temp, id: id)
                    self?.setWeatherIcon()
                    self?.setWeatherType()
                    DispatchQueue.main.async {
                        self?.delegate?.reloadData()
                    }
                }
            }
        }
    }
    
    private func setWeatherIcon() {
        if let id = weatherData?.id, let type = WeatherTypes.getWeatherType(by: id) {
            weatherData?.icon = type.value
            DispatchQueue.main.async {
                self.delegate?.updateIcon()
            }
        }
    }
    
    private func setWeatherType() {
    
        
        if let temp = weatherData?.temp {
            if temp >= 20 {
                currentWeatherType = .summer
            }
            else if temp >= 10 {
                currentWeatherType = .warmDemi
            }
            else if temp >= 0 {
                currentWeatherType = .coldDemi
            }
            else {
                currentWeatherType = .winter
            }
        }
    }
    
}
