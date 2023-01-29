//
//  ViewController.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import UIKit
import Foundation
import MapKit
import CoreLocation

class WeatherVC: UIViewController {
    
    let viewModel = WeatherViewModel()
    let locationManager = CLLocationManager()
    
    private var weatherStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
      
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.text = "23°C"
        return label
    }()
    
    private var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clear sky.png")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "London"
        label.textAlignment = .center
        return label
    }()
    
    private var citySearchButton: UIButton = {
        let button = UIButton()
        var image = UIImage.init(systemName: "magnifyingglass.circle")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private var picker: UIPickerView = {
        let picker = UIPickerView()
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 3
        }
        return picker
    }()
    
    private var whatToWearButton: UIButton = {
        let button = UIButton()
        button.setTitle("What to wear? →", for: .normal)
        return button
    }()
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor(red: 0.53, green: 0.75, blue: 0.82, alpha: 1.00).cgColor,
            UIColor(red: 0.07, green: 0.18, blue: 0.22, alpha: 1.00).cgColor,
            UIColor(red: 0.45, green: 0.65, blue: 0.72, alpha: 1.00).cgColor
        ]
        gradient.locations = [0, 0.5, 1]
        return gradient
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
        view.addSubview(weatherStackView)
        view.backgroundColor = .gray
        citySearchButton.addTarget(self, action: #selector(citySearchButtonTapped), for: .touchUpInside)
        whatToWearButton.addTarget(self, action: #selector(whatToWearButtonTappedd), for: .touchUpInside)
        addSubviewsForStacks()
        setConstraints()
        
        viewModel.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        if let city = cityLabel.text {
            viewModel.getWeatherByCity(city: city)
        }
        
    }

    private func addSubviewsForStacks() {
        
        weatherStackView.addArrangedSubview(cityLabel)
        weatherStackView.addArrangedSubview(weatherImageView)
        weatherStackView.addArrangedSubview(temperatureLabel)
        view.addSubview(citySearchButton)
        view.addSubview(whatToWearButton)
    }
    
    private func setConstraints() {
        
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        citySearchButton.translatesAutoresizingMaskIntoConstraints = false
        whatToWearButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        NSLayoutConstraint.activate([
            citySearchButton.heightAnchor.constraint(equalToConstant: 100),
            citySearchButton.widthAnchor.constraint(equalToConstant: 100),
            citySearchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            citySearchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -24),
        ])
        
        NSLayoutConstraint.activate([
            whatToWearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whatToWearButton.topAnchor.constraint(equalTo: weatherStackView.bottomAnchor)
        ])
    }
    
    @objc func citySearchButtonTapped() {
        presentSearchAlertController(withTitle: "Choose the city")
    }
    
    @objc func whatToWearButtonTappedd() {
        if let currentWeatherType = viewModel.currentWeatherType {
        let viewModel = ClothesViewModel(currentWeather: currentWeatherType)
        let clothesVC = ClothesVC(viewModel: viewModel)
        
            present(clothesVC, animated: true)
            
        }
    }

}

extension WeatherVC: WeatherViewModelDelegate {
    func updateIcon() {
        if let icon = viewModel.weatherData?.icon {
            weatherImageView.image = UIImage(named: icon)
        }
    }
    
    func reloadData() {
        if let temp = viewModel.weatherData?.temp {
            cityLabel.text = viewModel.weatherData?.name
            temperatureLabel.text = "\(Int(round(temp)))°C"
        }
    }
    
}

extension WeatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        guard let location: CLLocation = manager.location else { return }
        fetchCity(from: location) { city, error in
            guard let city = city, error == nil else { return }
            print(city)
        }
    }
    
    func fetchCity(from location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       error)
        }
    }
}
