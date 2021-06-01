//
//  OpenWeatherService.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 31/05/2021.
//

import Foundation

protocol OpenWeatherServiceProtocol {
    typealias WeatherDataCompletion = (WeatherModel?, Error?) -> ()

    static func weatherForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion)
}

class OpenWeatherService {
    typealias WeatherDataCompletion = (WeatherModel?, Error?) -> ()
    
    private static let host = "api.openweathermap.org"
    private static let fullPath = "/data/2.5/onecall"
    private static let apiKey = "07ee4f5e922183c2c49256d3e5011b4e"
    private static let metricUnit = "metric"
    
    
    static func weatherForLocation(latitude: Double, longitude: Double, completion: @escaping WeatherDataCompletion) {
        
        var urlBuilder = URLComponents()
        urlBuilder.scheme = "https"
        urlBuilder.host = host
        urlBuilder.path = fullPath
        urlBuilder.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "units", value: metricUnit),
            URLQueryItem(name: "appid", value: apiKey)
        ]
        
        let url = urlBuilder.url!
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherModel: WeatherModel = try decoder.decode(WeatherModel.self, from: data)
                    completion(weatherModel, error)
                } catch {
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
