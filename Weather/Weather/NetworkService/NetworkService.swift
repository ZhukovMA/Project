//
//  NetworkService.swift
//  Project_Weather
//
//  Created by Максим Жуков on 02/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import Foundation

struct DescriptionLocationModel {
    let location: String
    let longitude: String
    let latitude: String
}




class NetworkService {
    
    
    var session: URLSession
    
    init(){
        session = URLSession(configuration: .default)
    }
    
    
    
    
   func getData(url: URL, location: String, longitude: String, latitude: String, completion:  @escaping ([String: [Any]]?) -> Void) {

        
        session.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
            var weatherArray : [String: [Any]] = ["description": [],
                                                    "current": [],
                                                  "hourly": [],
                                                  "daily": []
            ]
            
            if let data = data {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject],
                        let current = json["currently"] as? [String:AnyObject],
                        let daily = json["daily"] as? [String:AnyObject],
                        let dailyData = daily["data"] as? [[String:AnyObject]],
                        let hourly = json["hourly"] as? [String:AnyObject],
                        let hourlyData = hourly["data"] as? [[String:AnyObject]]
                        else {
                            completion([:])
                            return
                    }
                    
                   let description =  DescriptionLocationModel(location: location, longitude: longitude, latitude: latitude)
                    weatherArray["description"]?.append(description)
                    guard let currentWeatherObject = CurrentWeatherModel(json: current) else {
                        completion([:])
                        return
                    }
                    weatherArray["current"]?.append(currentWeatherObject)
                    
                    for data in hourlyData {
                        guard let hourlyWeatherObject = HourlyWeatherModel(json: data) else {
                            continue
                        }
                        weatherArray["hourly"]?.append(hourlyWeatherObject)
                    }
                    
                    for data in dailyData {
                        guard let dailyWeatherObject = DailyWeatherModel(json: data) else {
                            continue
                        }
                        weatherArray["daily"]?.append(dailyWeatherObject)
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
                completion(weatherArray)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

