//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Ignacio Mariani on 31/05/2021.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataReceivedForLocation() {
        
        let cityNameExp = self.expectation(description: "Get city name")
        let timeExp = self.expectation(description: "Get time")
        let tempExp = self.expectation(description: "Get temp")
        let summaryExp = self.expectation(description: "Get weather summary")
        let windExp = self.expectation(description: "Get wind speed")
        let dewExp = self.expectation(description: "Get dew point")
        let humidityExp = self.expectation(description: "Get humidity percentage")
        
        let viewModel = WeatherViewModel()
        
        viewModel.cityNameModel.bind {
            if $0.caseInsensitiveCompare("Stockholm") == .orderedSame {
                cityNameExp.fulfill()
            }
        }
        
        viewModel.date.bind {
            if $0.caseInsensitiveCompare("Tue, 25 Sep 2018 13:37") == .orderedSame {
                timeExp.fulfill()
            }
        }
        
        viewModel.tempModel.bind {
            if $0.caseInsensitiveCompare("28º") == .orderedSame {
                tempExp.fulfill()
            }
        }
        
        viewModel.weatherDesc.bind {
            if $0.caseInsensitiveCompare("clear sky") == .orderedSame {
                summaryExp.fulfill()
            }
        }
        
        viewModel.windSpeed.bind {
            if $0.caseInsensitiveCompare("11.5") == .orderedSame {
                windExp.fulfill()
            }
        }
        
        viewModel.dewPoint.bind {
            if $0.caseInsensitiveCompare("7.14") == .orderedSame {
                dewExp.fulfill()
            }
        }
        
        viewModel.humidity.bind {
            if $0.caseInsensitiveCompare("0.65") == .orderedSame {
                humidityExp.fulfill()
            }
        }
        
        DispatchQueue.main.async {
            MockOpenWeatherService.weatherForLocation(latitude: 59.3310373, longitude: 18.0706638) { (weatherModelData, error) in
                do {
                    viewModel.setPropertiesValuesFromData(weatherData: weatherModelData!)
                }
            }
        }
        
        waitForExpectations(timeout: 8, handler: nil)
        
    }

}
