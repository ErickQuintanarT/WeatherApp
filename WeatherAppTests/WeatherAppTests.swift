//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Erick Quintanar on 5/13/24.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    var networkManager: NetworkManager!
    
    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchWeatherDataSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data success")
        
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(Constants.DefaultLocation.defaultLat)&lon=\(Constants.DefaultLocation.defaultLon)&appid=\(Constants.ApiKey.apiKey)&units=metric")!
        networkManager.fetchWeatherData(from: url) { (result: Result<WeatherModel, Error>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data.name, "Santa Monica")
                XCTAssertEqual(data.sys.country, "US")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch data with error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchImageDataSuccess() {
        
        let expectation = XCTestExpectation(description: "Fetch data success")
        
        let url = URL(string: "https://openweathermap.org/img/wn/01d@2x.png")!
        networkManager.fetchImageData(from: url) { result in
            switch result {
            case .success(let imageData):
                XCTAssertNotNil(UIImage(data: imageData), "Image data should be convertible to UIImage")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Failed to fetch image data with error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
