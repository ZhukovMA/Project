//
//  HourlyWeatherCollectionViewCell.swift
//  Project_Weather
//
//  Created by Максим Жуков on 30/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    
    
    let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let time: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let temperature: UILabel = {
        let label = UILabel()
        //        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(time)
        addSubview(icon)
        addSubview(temperature)
        
        
        backgroundColor = .white
        
        // icon constraints
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        // time constraints
        time.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        time.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        time.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        time.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        
        // temperature constraints
        temperature.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperature.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        temperature.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        temperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
