//
//  SushiModel.swift
//  Sushi App
//
//  Created by Алексей Пархоменко on 30/01/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import UIKit

struct HourlyWeatherModel {
    var icon: UIImage
    var time: String
    var temperature: Int64
}

extension HourlyWeatherModel {
    init?(json: [String : AnyObject]) {
        guard let temperature = json["temperature"] as? Double,
            let time = json["time"] as? Int,
            let iconString = json["icon"] as? String else {
                return nil
        }
        
        
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ru_RU") as Locale?
        dateFormatter.dateFormat = "HH"
        let resultsDate = dateFormatter.string(from: date)
        
        
        
        self.temperature = Int64(temperature)
        self.time = resultsDate
        self.icon = UIImage(named: iconString)!
    }
}

struct Constants {
    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.galleryMinimumLineSpacing / 2)) / 2
}
