//
//  ClothesVC.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import UIKit

class ClothesVC: UIViewController {
    
    private var whatToWearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "What to wear today?"
        return label
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
        
        view.addSubview(whatToWearLabel)
        setConstraints()

    }
    
    private func setConstraints() {
        whatToWearLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whatToWearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whatToWearLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
        ])
    }
}
