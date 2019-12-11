//
//  HeaderWeatherCell.swift
//  Project_Weather
//
//  Created by Максим Жуков on 30/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class HeaderWeatherCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let pressureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var summaryLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 7
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempretureLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 7
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var humidityLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 7
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var pressureLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 7
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(tempretureLabel)
        self.addSubview(humidityLabel)
        self.addSubview(pressureLabel)
        self.addSubview(summaryLabel)
        self.addSubview(pressureImageView)
        self.addSubview(humidityImageView)
        
        tempretureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        tempretureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60).isActive = true
        
        
        summaryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        summaryLabel.topAnchor.constraint(equalTo: tempretureLabel.bottomAnchor, constant: 20).isActive = true
        
        pressureImageView.bottomAnchor.constraint(equalTo: humidityImageView.topAnchor, constant: -20).isActive = true
        pressureImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        pressureImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/12).isActive = true
        pressureImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/12).isActive = true
        
        humidityImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        humidityImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        humidityImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/12).isActive = true
        humidityImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1/12).isActive = true
        
        pressureLabel.centerYAnchor.constraint(equalTo: pressureImageView.centerYAnchor).isActive = true
        pressureLabel.leftAnchor.constraint(equalTo: pressureImageView.rightAnchor, constant: 30).isActive = true
        
        humidityLabel.centerYAnchor.constraint(equalTo: humidityImageView.centerYAnchor).isActive = true
        humidityLabel.leftAnchor.constraint(equalTo: humidityImageView.rightAnchor, constant: 30).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
