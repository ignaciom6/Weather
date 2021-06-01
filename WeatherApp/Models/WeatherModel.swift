//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 31/05/2021.
//

import Foundation

struct WeatherModel: Codable {
    var lat: Double
    var lon: Double
    var timezone: String
    var current: CurrentWeather
    var daily: [DailyWeather]
}
