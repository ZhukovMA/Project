//
//  WeatherCell.swift
//  Project_Weather
//
//  Created by Максим Жуков on 29/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    
    var currentTemperature: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var location: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var time: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(location)
        self.addSubview(currentTemperature)
        self.addSubview(icon)
        
        location.leftAnchor.constraint(equalTo: leftAnchor,  constant: 12).isActive = true
        location.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        
        
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        currentTemperature.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        currentTemperature.leftAnchor.constraint(equalTo: leftAnchor, constant: 12).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
