//
//  LocationManager.swift
//  Project_Weather
//
//  Created by Максим Жуков on 08/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationManagerDelegate {
    func showAlertView(withTitle title:String, andText text: String)
    func setDataFromLocationManager(data: [String: [Any]])
}




class GeopositionManager: NSObject {
    var networkService : NetworkService!
    var apiManager: APIManagerProtocol!
    var coreDataManager = CoreDataManager()
    var delegate: LocationManagerDelegate?
    var locationManager = CLLocationManager()
    var currentLocation:CLLocation!
    
    override init() {
        networkService = NetworkService()
        super.init()
        apiManager = APIManager()
        checkLocation()
    }
    
    
    private func checkLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startMonitoringSignificantLocationChanges()
        } else {
            
        }
    }
    
    
    private func chekAutorizationLocation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            currentLocation = locationManager.location
            CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemark, error) in
                if error != nil
                {
                    print (error!)
                }
                else
                {
                    if let place = placemark?[0]
                    {
                        if let localion = place.locality
                        {
                            let url = self.apiManager.getPath(latitude: String(self.currentLocation.coordinate.latitude), longitude: String(self.currentLocation.coordinate.longitude))
                            self.networkService.getData(url: url, location: localion, longitude: String(self.currentLocation.coordinate.longitude), latitude: String(self.currentLocation.coordinate.latitude), completion: { (results) in
                                guard var result = results else {return}
                                let desWeatherObject = result["description"]![0] as! DescriptionLocationModel
                                var currentWeatherObject = result["current"]![0] as! CurrentWeatherModel
                                DispatchQueue.main.async {
                                    let favoritesArray = self.coreDataManager.retrieveData()
                                    let filteredArray = favoritesArray.filter( { (user: Weather) -> Bool in
                                        return user.locationName == desWeatherObject.location
                                    })
                                    if !filteredArray.isEmpty {
                                        currentWeatherObject.isFavorite = true
                                        result["current"]![0] = currentWeatherObject
                                            self.delegate?.setDataFromLocationManager(data: result)
                                    } else {
                                            self.delegate?.setDataFromLocationManager(data: result)
                                    }
                                }
                                
                                
                            })
                            
                            
                        }
                    }
                }
            }
            break
        case .denied:
            delegate?.showAlertView(withTitle: "Ошибка", andText: "Службы геолокации отключены")
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            delegate?.showAlertView(withTitle: "Ошибка", andText: "Приложение не авторизованно для служб геолокации")
            break
        case .authorizedAlways:
            break
        @unknown default:
            print(description)
            break
        }
    }
}

extension GeopositionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        chekAutorizationLocation()
    }
    
}
