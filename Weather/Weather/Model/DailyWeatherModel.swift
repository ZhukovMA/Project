//
//  CurrentWeatherModel.swift
//  Project_Weather
//
//  Created by Максим Жуков on 28/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit



struct DailyWeatherModel {
    let time: String
    let temperatureHigh: Int64
    let temperatureLow: Int64
    let icon: UIImage
}

extension DailyWeatherModel {
    init?(json: [String : AnyObject]) {
        guard let temperatureHigh = json["temperatureHigh"] as? Double,
            let temperatureLow = json["temperatureLow"] as? Double,
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
        self.temperatureHigh = Int64(temperatureHigh)
        self.temperatureLow = Int64(temperatureLow)
        self.icon =  UIImage(named: icon)!
    }
}
