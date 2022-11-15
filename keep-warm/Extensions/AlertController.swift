//
//  AlertController.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import Foundation
import UIKit

extension WeatherVC {
    func presentSearchAlertController(withTitle title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addTextField { textField in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            textField.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { [viewModel] action in
            let textField = alertController.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                viewModel.getWeatherByCity(city: city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(search)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
}
