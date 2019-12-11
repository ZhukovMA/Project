//
//  SearchAndFavoritesControllerTests.swift
//  WeatherTests
//
//  Created by Максим Жуков on 11/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import XCTest
import CoreLocation

@testable import Weather

class SearchAndFavoritesControllerTests: XCTestCase {
    var sut : SearchAndBookmarkController!
//    var placemark: MockCLPlacemark!
    override func setUp() {
        super.setUp()
        sut = SearchAndBookmarkController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    

    func testIsCalledSetupNavigationBarItem() {
        //arrange
        
        //act
        sut.setupNavigationBarItem()
        
        //assert
        XCTAssertTrue(sut.title == "Избранное", "Метод не вызвался")
    }
    
    func testIsCalledfetchWeather() {
        //arrange
        let addressString = "Уфа"
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        
        //act

        sut.fetchWeather(with: addressString)
    
        //assert
        XCTAssert(mockGeocoder.isCalled, "Не вызван")
    }
    

}

  

extension SearchAndFavoritesControllerTests {
    class MockTableView: UITableView {
        
    }
    
    class MockCLGeocoder: CLGeocoder {
        
        var isCalled: Bool = false
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            isCalled = true
        }
    }
    
    class MockAPIManager: APIManagerProtocol {
        var isCalled: Bool = false
        func getPath(latitude: String, longitude: String) -> URL {
            isCalled = true
            return URL(fileURLWithPath: "https://vk.com")
        }
    }
    
   
    
   
}
