//
//  MainViewControllerTests.swift
//  WeatherTests
//
//  Created by Максим Жуков on 10/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import XCTest
@testable import Weather

class MainViewControllerTests: XCTestCase {
    var sut: MainViewController!
    override func setUp() {
        super.setUp()
        sut = MainViewController()
    }

    override func tearDown() {
        
        sut = nil
        super.tearDown()
    }
    
    func testIsCalledSetupTableView() {
        // arrange
        let mockTableView = MockTableView()
        sut.tableView = mockTableView

        // act
        sut.setupTableView()
        // assert
        XCTAssertNotNil(mockTableView.backgroundColor, "Метод не вызвался")
        
    }

    func testIsCalledSetupNavBar() {
        // arrange

        // act
        sut.setupNavBar()

        // assert
        XCTAssertNotNil(sut.navigationItem.leftBarButtonItem, "Метод не вызвался")

    }
    

    
    func testIsCalledSetData() {
        // arrange
        let mockSearchAndFavoritesController = MockSearchAndFavoritesController()
        sut.searchController.delegate = mockSearchAndFavoritesController
        let data = ["Foo" : ["Foo"]]
        
        //act
        sut.searchController.delegate!.setData(data: data)
        
        // assert
        XCTAssertTrue(mockSearchAndFavoritesController.setDataGotCalled, "Метод не вызвался")
    }
    

}

extension MainViewControllerTests {
    class MockTableView: UITableView {
        var cellIsDequeued = false
        
    }
    
    class MockSearchAndFavoritesController : SearchAndBookmarkDelegate {
        var setDataGotCalled = false
        func setData(data: [String : [Any]]) {
            setDataGotCalled = true
        }
    }
}
