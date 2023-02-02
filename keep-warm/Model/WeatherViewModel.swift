//
//  WeatherViewModel.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 23.10.2022.
//

import Foundation
import MapKit
import CoreLocation

protocol WeatherViewModelDelegate: AnyObject {
    func setCurrentCity(with name: String)
    func reloadData()
    func updateIcon()
}

class WeatherViewModel: NSObject {

    struct WeatherData {
        let name: String
        let temp: Double
        let id: Int
        var icon: String = ""
    }
    
    var networkWeatherManager: INetworkManager = NetworkWeatherManager()
    let locationManager = CLLocationManager()
    
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
    
    func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        let queue = DispatchQueue(label: "location.queue")
        queue.async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    func changeUnits() {
        if networkWeatherManager.units == "metric" {
            networkWeatherManager.units = "imperial"
        }
        else {
            networkWeatherManager.units = "metric"
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

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        guard let location: CLLocation = manager.location else { return }
        fetchCity(from: location) { [weak self] city, error in
            guard let city = city, error == nil else { return }
            self?.getWeatherByCity(city: city.replacingOccurrences(of: " ", with: "+"))
        }
    }
    
    func fetchCity(from location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { [locationManager] placemarks, error in
            completion(placemarks?.first?.locality, error)
            locationManager.stopUpdatingLocation()
        }
    }
}
