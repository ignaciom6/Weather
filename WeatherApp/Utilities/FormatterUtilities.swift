//
//  FormatterUtilities.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 01/06/2021.
//

import UIKit

class FormatterUtilities: NSObject {
    
    class func getDateFrom(unix: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unix))
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = NSLocale.current
        
        formatter.dateFormat = "E, d MMM yyyy HH:mm"
        
        let strDate = formatter.string(from: date)
        
        return strDate
    }
    
    class func getDay(unix: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unix))
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.locale = NSLocale.current
        
        formatter.dateFormat = "EEEE"
        
        let strDate = formatter.string(from: date)
        
        return strDate
    }
    
    class func getCityName(cityName: String) -> String {
        let location = cityName.components(separatedBy: "/")
        let name = location.last ?? "N/A"
        
        return name.replacingOccurrences(of: "_", with: " ")
    }
    
    class func getFormattedTemp(fullTemp: Double) -> String {
        return String(format:"%.0f"+"º", fullTemp)
    }
}
