//
//  WeatherDataCell.swift
//  WeatherAppC4Q
//
//  Created by zahid arsalan on 1/7/17.
//  Copyright © 2017 appavenge. All rights reserved.
//

import UIKit

class WeatherDataCell: UITableViewCell {
    
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastDate: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
   // var descriptinnArray = [String]()
    
    func fillCell(forecast: WeatherData) {
        forecastDate.text = forecast.date
        lowTemp.text = forecast.minTemp
        highTemp.text = forecast.maxTemp
       // forecastImage.image = UIImage(named: forecast.image)
        
        print("IMAGEEE2-------\(forecast.image)")
    }
        
    

    
    
    
}
