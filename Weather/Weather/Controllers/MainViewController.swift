//
//  SearchAndBookmarkController.swift
//  Project_Weather
//
//  Created by Максим Жуков on 28/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
import CoreLocation


protocol MainControllerOutput {
    func setFavoritesData(data:  [String : [Any]]) -> [String : [Any]]
}


class MainViewController: UIViewController, SearchAndBookmarkDelegate, LocationManagerDelegate {
    
    var geopositionManager : GeopositionManager!
    
    var output: MainControllerOutput?
    var scrollView: UIScrollView!
    var searchController = SearchAndBookmarkController()
    var weatherData = [String : [Any]]()
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geopositionManager = GeopositionManager()
        geopositionManager.delegate = self
        searchController.mainViewController = self
        searchController.mainViewController?.output = searchController
        searchController.delegate = self
        setupNavBar()
        setupTableView()
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    func setData(data: [String : [Any]])  {
        let descriptionWeather =  data["description"]![0] as! DescriptionLocationModel
        self.title = descriptionWeather.location
        weatherData = data
        changeImageRightButton()
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.layoutIfNeeded()
        tableView.reloadData()
    }
    
    func setDataFromLocationManager(data: [String : [Any]]) {
        print(Thread.isMainThread)
        let descriptionWeather =  data["description"]![0] as! DescriptionLocationModel
        self.title = descriptionWeather.location
        weatherData = data
        changeImageRightButton()
        tableView.contentOffset = CGPoint(x: 0, y: 0)
        tableView.layoutIfNeeded()
        tableView.reloadData()
    }
    
    func setupNavBar() {
        let imagee = UIImage(named: "search")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imagee, style: .plain, target: self, action: #selector(action))
        
        let image = UIImage(named: "star1")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(setFavorite))
    }
    
    private func changeImageRightButton() {
        let currentWeather =  weatherData["current"]![0] as! CurrentWeatherModel
        if currentWeather.isFavorite {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "star2")
        } else {
            navigationItem.rightBarButtonItem?.image = UIImage(named: "star1")
        }
    }
    
    func showAlertView(withTitle title:String, andText text: String) {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func setFavorite() {
        var currentWeather =  weatherData["current"]![0] as! CurrentWeatherModel
        if currentWeather.isFavorite {
            weatherData = output!.setFavoritesData(data: weatherData)
            currentWeather.isFavorite = false
            weatherData["current"]![0] = currentWeather
            navigationItem.rightBarButtonItem?.image = UIImage(named: "star1")
        } else {
            weatherData = output!.setFavoritesData(data: weatherData)
            currentWeather.isFavorite = true
            weatherData["current"]![0] = currentWeather
            navigationItem.rightBarButtonItem?.image = UIImage(named: "star2")
        }
    }
    
    @objc func action() {
        navigationController?.pushViewController(searchController, animated: true)
    }
    
    func setupTableView() {
        tableView.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        tableView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(HeaderWeatherCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: "HourlyCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: -(navigationController?.navigationBar.frame.maxY)!, left: 0, bottom: 0, right: 0)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        changeNavigationStyle(with: self.scrollView)
        
    }
    
    private func changeNavigationStyle(with scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y / 150
        if(offset > 0.6) {
            navigationController?.navigationBar.barStyle = .default
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            
        } else {
            navigationController?.navigationBar.barStyle = .black
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: min(1, offset))
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: min(1, offset))
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
        changeNavigationStyle(with: self.scrollView)
    }
}




extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return view.bounds.height * 2/3
        } else if indexPath.row == 1 {
            return  120
        } else{
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderWeatherCell
            cell.selectionStyle = .none
            if let _ = weatherData["current"] {
                let b =  weatherData["current"]![0] as? CurrentWeatherModel
                // tempretureLabel
                cell.tempretureLabel.text = String(b!.temperature) + "°"
                cell.tempretureLabel.font = cell.tempretureLabel.font.withSize(cell.bounds.width * 0.2)
                
                // summaryLabel
                cell.summaryLabel.text = String(b!.summary)
                cell.summaryLabel.font = cell.summaryLabel.font.withSize(cell.bounds.width * 0.06)
                
                // pressureImageView
                cell.pressureImageView.image = UIImage(named: "p")
                
                // humidityImageView
                cell.humidityImageView.image = UIImage(named: "humidity")
                
                cell.pressureLabel.text = String(b!.pressure) + " мм. рт. ст."
                cell.pressureLabel.font = cell.pressureLabel.font.withSize(cell.bounds.width * 0.06)
                
                cell.humidityLabel.text = String(b!.humidity) + "%"
                cell.humidityLabel.font = cell.humidityLabel.font.withSize(cell.bounds.width * 0.06)
                
            }
            cell.backgroundColor = UIColor.clear
            return cell
            
        } else if(indexPath.row == 1){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HourlyCell", for: indexPath) as! HourlyWeatherCell
            cell.selectionStyle = .none
            if let _ = weatherData["hourly"], let cells = weatherData["hourly"] as? [HourlyWeatherModel] {
                cell.collectionView.frame = cell.bounds
                cell.setData(data: cells)
                cell.collectionView.reloadData()
            }
            cell.backgroundColor = .clear
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherCell
            cell.selectionStyle = .none
            if let _ = weatherData["daily"],
                let cells = weatherData["daily"] as? [DailyWeatherModel] {
                cell.day.text = cells[indexPath.row - 2].time
                cell.icon.image = cells[indexPath.row - 2].icon
                cell.afternoonTemperature.text = String(cells[indexPath.row - 2].temperatureHigh) + "°"
                cell.nightTempetature.text =  String(cells[indexPath.row - 2].temperatureLow) + "°"
            }
            cell.backgroundColor = UIColor.clear
            return cell
        }
    }
}



