//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 01/06/2021.
//

import Foundation

struct DailyWeather: Codable {
    var dt: Int
    var temp: TempModel
}
