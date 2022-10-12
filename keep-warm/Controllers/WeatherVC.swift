//
//  ViewController.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import UIKit

// TODO: градиентный фон для разной погоды или смена фоновых изображений
// TODO: замена weatherImage в зависимости от погоды
// TODO: вопрос с вариантами ответа

class WeatherVC: UIViewController {
    
    
    @IBAction func changeCityButton(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert)
    }
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }


}

