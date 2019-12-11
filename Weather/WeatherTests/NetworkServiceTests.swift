//
//  NetworkServiceTests.swift
//  WeatherTests
//
//  Created by Максим Жуков on 11/12/2019.
//  Copyright © 2019 Максим Жуков. All rights reserved.
//

import XCTest

class NetworkServiceTests: XCTestCase {
    var sut: NetworkService!
    var mockURLSession: MockURLSession!
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = NetworkService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoginUsesCorrectHost() {
        sut.session = mockURLSession
        sut.getData(url: URL(string: "https://darksky.net/dev/login")!, location:"Москва", longitude: "23234", latitude: "3432", completion: {([String : [Any]]?)  in })

        XCTAssertEqual(mockURLSession.components?.host, "darksky.net")
    }

    func testLoginUsesCorrectPath() {
        sut.session = mockURLSession
        sut.getData(url: URL(string: "https://darksky.net/dev/login")!, location: "Москва", longitude: "23234", latitude: "3432", completion: {([String : [Any]]?)  in })
        XCTAssertEqual(mockURLSession.components?.path, "/dev/login")
    }
}

extension NetworkServiceTests {
    class MockURLSession: URLSession {
      let mockURLSessionDataTask = MockURLSessionDataTask(data: nil, urlResponse: nil, responseError: nil)
        var components: URLComponents?

        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            components = URLComponents(url: url, resolvingAgainstBaseURL: true)
            return mockURLSessionDataTask
        }
    }

    class MockURLSessionDataTask: URLSessionDataTask {

        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?

        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?

        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }

        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}

