//
//  ViewController.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import UIKit
import Foundation

class WeatherVC: UIViewController {
    
    let viewModel = WeatherViewModel()
    
    private var weatherStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
      
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
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
    
    private lazy var cityLabel: UILabel = {
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
    
    private var unitsButton: UIButton = {
        let button = UIButton()
        button.setTitle("change units", for: .normal)
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
        whatToWearButton.addTarget(self, action: #selector(whatToWearButtonTapped), for: .touchUpInside)
        unitsButton.addTarget(self, action: #selector(unitsButtonTapped), for: .touchUpInside)
        addSubviewsForStacks()
        setConstraints()
        
        viewModel.delegate = self
        viewModel.getCurrentLocation()
    }

    private func addSubviewsForStacks() {
        
        weatherStackView.addArrangedSubview(cityLabel)
        weatherStackView.addArrangedSubview(weatherImageView)
        weatherStackView.addArrangedSubview(temperatureLabel)
        view.addSubview(citySearchButton)
        view.addSubview(whatToWearButton)
        view.addSubview(unitsButton)
    }
    
    private func setConstraints() {
        
        weatherStackView.translatesAutoresizingMaskIntoConstraints = false
        citySearchButton.translatesAutoresizingMaskIntoConstraints = false
        whatToWearButton.translatesAutoresizingMaskIntoConstraints = false
        unitsButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        NSLayoutConstraint.activate([
            unitsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unitsButton.centerYAnchor.constraint(equalTo: citySearchButton.centerYAnchor)
        ])
    }
    
    @objc func citySearchButtonTapped() {
        presentSearchAlertController(withTitle: "Choose the city")
    }
    
    @objc func whatToWearButtonTapped() {
        if let currentWeatherType = viewModel.currentWeatherType {
        let viewModel = ClothesViewModel(currentWeather: currentWeatherType)
        let clothesVC = ClothesVC(viewModel: viewModel)
        
            present(clothesVC, animated: true)
            
        }
    }

    @objc func unitsButtonTapped() {
        print(viewModel.networkWeatherManager.units)
        viewModel.changeUnits()
        print(viewModel.networkWeatherManager.units)
    }
}

extension WeatherVC: WeatherViewModelDelegate {
    func setCurrentCity(with name: String) {
        cityLabel.text = name
    }
    
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
