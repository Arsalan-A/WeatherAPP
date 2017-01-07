//
//  ViewController.swift
//  WeatherAppC4Q
//
//  Created by arsalan on 1/7/17.
//  Copyright © 2017 appavenge. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var currentWeatherData: WeatherData!
    var forecasts = [WeatherData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       // currentWeatherData = WeatherData()
        tableView.delegate = self
        tableView.dataSource = self
        
        Alamofire.request(WEATHER_URL).responseJSON {response in
            let result = response.result.value
           // print("RESPOOOSSNSEE\(result)")
            
            if let weatherData = result as? Dictionary<String, AnyObject> {
                
                if let data = weatherData["response"] as? [Dictionary<String, AnyObject>] {
                   //print("RESPOOOSSNSEE\(data)")
        
                    if let periods = data[0]["periods"] as? [Dictionary<String, AnyObject>] {
                      
                    //Get the JSON DATA for the the current temperature
                        if let currentTemp = periods[0]["avgTempF"] as? Double {
                            self.tempLabel.text = "\(Int(currentTemp))°"
                        }
                        
                   //Get the JSON Data for the weatherType
                        if let currentWeatherType = periods[0]["weatherPrimary"] as? String {
                            self.weatherTypeLabel.text = currentWeatherType
                        }
                    
                  //Create dictionaries and add it to the arrays from the JSON Data
                        for dicts in periods{
                            let forecast = WeatherData(dataDicts: dicts)
                            self.forecasts.append(forecast)
                            
                            print("WeatherData\(dicts)")
                        }
                        
                //Remove Todays forecast
                    self.forecasts.removeFirst()
                        
                //Reload the data in the tableView
                    self.tableView.reloadData()
                        
                    }
                
                }
            
            }
            
        }
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? WeatherDataCell {
            let forecastData = forecasts[indexPath.row]
            cell.fillCell(forecast: forecastData)
            return cell
        }else{
            return WeatherDataCell()
        }
        
        
    }


    
}

