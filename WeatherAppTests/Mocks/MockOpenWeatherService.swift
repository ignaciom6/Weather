//
//  MockOpenWeatherService.swift
//  WeatherAppTests
//
//  Created by Ignacio Mariani on 01/06/2021.
//

import Foundation
@testable import WeatherApp

class MockOpenWeatherService {
    
}

extension MockOpenWeatherService: OpenWeatherServiceProtocol {
    typealias WeatherDataCompletion = (WeatherModel?, Error?) -> ()

    static func weatherForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        
        let tempMock = TempModel(min: 21.1, max: 28.3)
        
        let dailyMock = DailyWeather(dt: 1537882620, temp: tempMock)
        
        let weatherDescMock = WeatherDescription(main: "Clear",
                                                 description: "clear sky")
        
        let currentWeatherMock = CurrentWeather(temp: 28.46,
                                                dt: 1537882620,
                                                weather: [weatherDescMock],
                                                humidity: 0.65,
                                                windSpeed: 11.5,
                                                dewPoint: 7.14)
                
        let mockWeather = WeatherModel(lat: 59.3310373,
                                       lon: 18.0706638,
                                       timezone: "Europe/Stockholm",
                                       current: currentWeatherMock,
                                       daily: [dailyMock])
        
        completion(mockWeather, nil)
    }
    

}
