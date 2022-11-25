//
//  NetworkWeatherManager.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import Foundation

enum WeatherError: Error {
    case wrongUrl
    case responseError
    case dataError
}

struct Weather: Decodable {
    let main: String?
    let icon: String?
    let id: Int?
}

struct MainInfo: Decodable {
    let temp: Double
}

struct WeatherCast: Decodable {
    let weather: [Weather]?
    let main: MainInfo?
    let name: String?
    let timezone: Int?
    let wind: Wind?
}

struct Wind: Decodable {
    let speed: Double?
}

struct NetworkWeatherManager {
    
    func fetchCurrentWeather(forCity city: String, handle: @escaping((Result<WeatherCast, WeatherError>) -> ())) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(Constants.apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            handle(.failure(.wrongUrl))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, error in
            if error != nil {
                handle(.failure(.responseError))
            } else if let data = data {
                
                do {
                    let weather = try JSONDecoder().decode(WeatherCast.self, from: data)
                    handle(.success(weather))
                } catch {
                    handle(.failure(.dataError))
                }
                
            } else {
                handle(.failure(.dataError))
            }
        }
        task.resume()
    }
}
