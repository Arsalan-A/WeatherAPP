//
//  WeatherData.swift
//  WeatherAppC4Q
//
//  Created by zahid arsalan on 1/7/17.
//  Copyright © 2017 appavenge. All rights reserved.
//

import Foundation

class WeatherData {
    var _currentTemp: String!
    var _minTemp: String!
    var _maxTemp: String!
    var _date: String!
    var _weatherType: String!
    
    var currentTemp: String{
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    var minTemp: String {
        if _minTemp == nil {
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil {
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }

    init(dataDicts: Dictionary<String, AnyObject>){
        if let maxTemp = dataDicts["maxTempF"] as? Double {
            
            self._maxTemp = String(Int(maxTemp))
        
        }
        
        if let minTemp = dataDicts["minTempF"] as? Double{
            self._minTemp = String(Int(minTemp))
        
        }
        
        if let date = dataDicts["timestamp"] as? Int {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let daysDate = dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
            _date = daysDate
        
        }
    
    }
    

    
    
    
    
    
    
    
    
}
