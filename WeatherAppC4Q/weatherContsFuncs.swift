//
//  weatherConstants.swift
//  WeatherAppC4Q
//
//  Created by arsalan on 1/7/17.
//  Copyright © 2017 appavenge. All rights reserved.
//

import Foundation

let WEATHER_URL = "http://api.aerisapi.com/forecasts/11101?client_id=4jPRn17yELO9SqViBnxDb&client_secret=ynB1HjJr2ABaMjp0NBO7NDjUjXVmHQ0rL3yIksXB"

func fahrenheitToCelcius(fah: String) -> String{
    
    let celcius = (Double(fah)!-32)*(5/9)
    
    let rounded = round(celcius)
    
    return String(Int(rounded))
    
    
}

func celciusToFahrenheit(cel: String) -> String {
    let fahrenheit = (Double(cel)!*(9/5)+32)
    
    let rounded = round(fahrenheit)
    
    return String(Int(rounded))
}
