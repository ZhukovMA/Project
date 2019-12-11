//
//  CurrentWeatherModel.swift
//  Project_Weather
//
//  Created by Максим Жуков on 28/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit



struct FavoritesWeatherModel {
    let time: String
    let temperatureLow: Int
    let icon: UIImage
}

extension FavoritesWeatherModel {
    init?(json: [String : AnyObject]) {
        guard let temperatureLow = json["temperature"] as? Double,
            let icon = json["icon"] as? String,
            let time = json["time"] as? Int
            else {
                return nil
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ru_RU") as Locale?
        dateFormatter.dateFormat = "EEEE"
        let resultsDate = dateFormatter.string(from: date)
        
        
        self.time = resultsDate
        self.temperatureLow = Int(temperatureLow)
        self.icon =  UIImage(named: icon)!
    }
}
