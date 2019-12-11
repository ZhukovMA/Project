//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Максим Жуков on 28/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit



struct CurrentWeatherModel {
    var isFavorite: Bool
    let temperature: Int64
    let summary: String
  
    let pressure: Int64
    let humidity: Int64
    let icon: UIImage
}

extension CurrentWeatherModel {
    init?(json: [String : AnyObject]) {
        guard let temperature = json["temperature"] as? Double,
            let summary = json["summary"] as? String,
            let humidity = json["humidity"] as? Double,
            let pressure = json["pressure"] as? Double,
            let iconString = json["icon"] as? String else {
                return nil
        }
       
        self.temperature = Int64(temperature)
        self.humidity = Int64(humidity * 100)
        self.pressure = Int64(pressure * 0.75)
        self.summary = summary
        self.icon =  UIImage(named: iconString)!
        self.isFavorite = false
 
    }
}
