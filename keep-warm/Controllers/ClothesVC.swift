//
//  ClothesVC.swift
//  keep-warm
//
//  Created by Дарья Тимофеева on 12.10.2022.
//

import UIKit

class ClothesVC: UIViewController {
    
    let viewModel: ClothesViewModel
    
    init(viewModel: ClothesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        //collectionView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        return collectionView
    }()
    
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
        view.addSubview(collectionView)
        setConstraints()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ClothesCell.self, forCellWithReuseIdentifier: ClothesCell.identifier)

    }
    
    private func setConstraints() {
        
        whatToWearLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whatToWearLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whatToWearLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 72),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }
}

extension ClothesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.clothesForCurrentWeather.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClothesCell.identifier, for: indexPath) as? ClothesCell {
            let images = viewModel.clothesForCurrentWeather
            let imageName = images[indexPath.item]
                cell.configure(image: UIImage(named: imageName))
            return cell
        }
        return UICollectionViewCell(frame: .zero)
    }
    
}

extension ClothesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxWidth = UIScreen.main.bounds.width - 32
        let width = maxWidth / 2 - 8
        return CGSize(width: width, height: width)
    }
}
