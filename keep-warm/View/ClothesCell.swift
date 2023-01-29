//
//  ClothesCell.swift
//  keep-warm
//
//  Created by Екатерина Батеева on 06.12.2022.
//

import UIKit

class ClothesCell: UICollectionViewCell {
    
    static let identifier = "clothesCell"
    
    private var clothesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        contentView.addSubview(clothesImageView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage?) {
        clothesImageView.image = image
    }
    
    func setConstraints() {
        clothesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clothesImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            clothesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            clothesImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            clothesImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
}
