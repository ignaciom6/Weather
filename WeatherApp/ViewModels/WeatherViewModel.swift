//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 01/06/2021.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject {
    
    private static let kLocationNeededError = "Location services needed"
    private static let kError = "Error"
    
    private var locationMgr: CLLocationManager?
    var cityNameModel = Box("Loading...")
    var tempModel = Box("--º")
    var date = Box("-")
    var weatherDesc = Box("-")
    var windSpeed = Box("-")
    var dewPoint = Box("-")
    var humidity = Box("-")
    var error = Box("")
    var dailyWeather: Box<[DailyWeather]?> = Box(nil)
    
    override init() {
        super.init()
        getLocation()
    }
    
    func getLocation() {
        locationMgr = CLLocationManager()
        locationMgr?.requestAlwaysAuthorization()
        locationMgr?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationMgr?.delegate = self
            locationMgr?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationMgr?.startUpdatingLocation()
        }
    }
    
    func requestWeatherInfoForLocation(location: CLLocationCoordinate2D) {
        OpenWeatherService.weatherForLocation(latitude: location.latitude, longitude: location.longitude) { [weak self] (weatherModelData, error) in
            guard let self = self else {return}
            guard let weatherModelData = weatherModelData
                else{
                    self.error.value = error?.localizedDescription ?? WeatherViewModel.kError
                    return
            }
            self.setPropertiesValuesFromData(weatherData: weatherModelData)
        }
    }
    
    func setPropertiesValuesFromData(weatherData: WeatherModel) {
        self.cityNameModel.value = FormatterUtilities.getCityName(cityName: weatherData.timezone)
        self.tempModel.value = FormatterUtilities.getFormattedTemp(fullTemp: weatherData.current.temp)
        self.date.value = FormatterUtilities.getDateFrom(unix: weatherData.current.dt)
        self.weatherDesc.value = weatherData.current.weather.first?.description ?? ""
        self.windSpeed.value = String(weatherData.current.windSpeed)
        self.dewPoint.value = String(weatherData.current.dewPoint)
        self.humidity.value = String(weatherData.current.humidity)
        self.dailyWeather.value = weatherData.daily
    }
    
}

extension WeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        
        requestWeatherInfoForLocation(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            self.error.value = WeatherViewModel.kLocationNeededError
        }
    }
}
