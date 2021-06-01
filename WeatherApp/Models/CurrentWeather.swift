//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 31/05/2021.
//

import Foundation

struct CurrentWeather: Codable {
    var temp: Double
    var dt: Int
    var weather: [WeatherDescription]
    var humidity: Double
    var windSpeed: Double
    var dewPoint: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case dt
        case weather
        case humidity
        case windSpeed = "wind_speed"
        case dewPoint = "dew_point"
    }
}
