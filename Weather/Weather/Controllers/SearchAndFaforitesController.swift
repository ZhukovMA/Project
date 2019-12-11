//
//  SearchAndBookmarkController.swift
//  Project_Weather
//
//  Created by Максим Жуков on 28/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

protocol SearchAndBookmarkDelegate: AnyObject {
    func setData(data: [String: [Any]])
}

class SearchAndBookmarkController: UIViewController, MainControllerOutput {
    var networkService : NetworkService!
    var apiManager: APIManagerProtocol!
    var coreDataManager : CoreDataManagerProtocol!
    var favoritesArray : [Weather] = []
    weak var delegate : SearchAndBookmarkDelegate?
    var mainViewController : MainViewController?
    var searchBar: UISearchBar!
    var tableView = UITableView()
    var geocoder : CLGeocoder!
    
    func retrieveData(data: [Weather]) {
        favoritesArray = data
    }
    
    func setFavoritesData(data: [String : [Any]]) -> [String : [Any]] {
        tableView.beginUpdates()
        var weatherObject =  data
        var currentWeatherObject = weatherObject["current"]![0] as! CurrentWeatherModel
        let desWeatherObject = weatherObject["description"]![0] as! DescriptionLocationModel
        if currentWeatherObject.isFavorite {
            
            coreDataManager.removeData(locationName: desWeatherObject.location) { (results) in
                if let result = results {
                    self.favoritesArray = result
                    let indexPath = IndexPath(row: self.favoritesArray.count, section: 0)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
        } else {
            
            currentWeatherObject.isFavorite = true
            weatherObject["current"]![0] = currentWeatherObject
            let indexPath = IndexPath(row: favoritesArray.count, section: 0)
            coreDataManager.saveAsEntity(data: weatherObject) { (result) in
                if let result = result {
                    self.tableView.insertRows(at: [indexPath], with: .fade)
                    self.favoritesArray = result
                }
            }
        }
        tableView.endUpdates()
        return weatherObject
    }
    
    func updateCurrentWeatherForFavorites() {
        for currentItem in 0...(favoritesArray.count-1) {
            let item = favoritesArray[currentItem]
            let url = apiManager.getPath(latitude: item.latitude!, longitude: item.longitude!)
            self.networkService.getData(url: url, location: item.locationName!, longitude: item.longitude!, latitude: item.latitude!) { (results) in
                self.coreDataManager.update(data: results!, completion: { (result) in
                    self.favoritesArray[currentItem] = result!
                })
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService = NetworkService()
        coreDataManager = CoreDataManager()
        favoritesArray = coreDataManager.retrieveData()
        geocoder = CLGeocoder()
        tableView.reloadData()
        apiManager = APIManager()
        tableView.tableFooterView = UIView()
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 45))
        tableView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        tableView.tableHeaderView = searchBar
        tableView.contentSize = tableView.bounds.size
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        mainViewController!.output = self
        searchBar.delegate = self
        coreDataManager = CoreDataManager()
        view.addSubview(tableView)
    }
    
    
    func setupNavigationBarItem() {
        self.title = "Избранное"
        navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        UIApplication.shared.statusBarView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back100"), style: .done, target: self, action: #selector(action))
    }
    
    @objc func action() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setupNavigationBarItem()
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    
    func showAlertView(withTitle title:String, andText text: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
                
            })
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    var resultstr: CLPlacemark!
    
    func fetchWeather(with location:String) {
        
        geocoder.geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
            guard error == nil,
                let placemarksLocation = placemarks?.first?.location,
                let locality = placemarks?.first?.locality  else {
                    self.showAlertView(withTitle: "Ошибка", andText: "Не удалось найти местоположение")
                    return
            }
            self.resultstr = placemarks?.first
            let filteredArray = self.favoritesArray.filter( { (user: Weather) -> Bool in
                return user.locationName ==  locality
            })
            if !filteredArray.isEmpty {
                self.coreDataManager.fetchAsDictionary(data: filteredArray[0], completion: { (results) in
                    if let result = results {
                        DispatchQueue.main.async {
                            self.delegate?.setData(data: result)
                            self.navigationController?.popViewController(animated: true)
                            return
                        }
                    }
                })
            } else {
                let url = self.apiManager.getPath(latitude: String(placemarksLocation.coordinate.latitude), longitude: String(placemarksLocation.coordinate.longitude))
                
                self.networkService.getData(url: url,
                                       location: locality,
                                       longitude: String(placemarksLocation.coordinate.longitude),
                                       latitude: String(placemarksLocation.coordinate.latitude),
                                       completion: { results in
                                        guard let result = results else {
                                            self.showAlertView(withTitle: "Ошибка", andText: "Не удалось загрузить данные")
                                            return
                                        }
                                        DispatchQueue.main.async {
                                            self.delegate?.setData(data: result)
                                            self.navigationController?.popViewController(animated: true)
                                        }
                })
            }
        }
    }
}



extension SearchAndBookmarkController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        fetchWeather(with: searchBar.text!)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
}


extension SearchAndBookmarkController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coreDataManager.fetchAsDictionary(data: favoritesArray[indexPath.row]) { (results) in
            if let result = results {
                self.delegate?.setData(data: result)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoritesCell
        if favoritesArray.isEmpty {
            return cell
        } else {
            guard let currentWeather = favoritesArray[indexPath.row].current?.array as? [CurrentWeather] else {
                return cell
            }
            
            
            cell.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            cell.location.text = favoritesArray[indexPath.row].locationName
            cell.currentTemperature.text = String(currentWeather[0].temperature) + "°"
            cell.icon.image = UIImage(data: currentWeather[0].icon!)
            return cell
        }
        
    }
    
    
}
