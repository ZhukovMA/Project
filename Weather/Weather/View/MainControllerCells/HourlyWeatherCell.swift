//
//  HeaderWeatherCell.swift
//  Project_Weather
//
//  Created by Максим Жуков on 30/11/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    var cells = [HourlyWeatherModel]()
    
    
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        
        
        
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = UIColor.clear
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        //        cells = fetchSushi()
        self.addSubview(collectionView)
    }
    
    func setData(data: [HourlyWeatherModel]) {
        cells = data
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: frame.height )
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cells.count >= 25 {
            return 24
        }
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! HourlyWeatherCollectionViewCell
        if cells.count >= 25 {
            cell.icon.image = cells[indexPath.row + 1].icon
            cell.temperature.text = String(Int(cells[indexPath.row + 1].temperature)) + "°"
            cell.time.text = String(cells[indexPath.row + 1].time)
            cell.backgroundColor = UIColor.clear
        }
        
        return cell
    }
    
    
}
