//
//  WeatherCell.swift
//  Project_Weather
//
//  Created by Максим Жуков on 29/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    
    var afternoonTemperature: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var nightTempetature: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var day: UILabel = {
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
        
        self.addSubview(day)
        self.addSubview(afternoonTemperature)
        self.addSubview(nightTempetature)
        self.addSubview(icon)
        
        day.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        day.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        icon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        nightTempetature.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nightTempetature.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        
        afternoonTemperature.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        afternoonTemperature.rightAnchor.constraint(equalTo: nightTempetature.leftAnchor, constant: -20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
