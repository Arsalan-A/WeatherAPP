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

//Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var tableView: UITableView!

//Properties
    var getCurrentTemp = ""
    var currentWeatherData: WeatherData!
    var forecasts = [WeatherData]()
    var weatherDescriptionArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.delegate = self
        tableView.dataSource = self
        
      //Get weather Data
        Alamofire.request(WEATHER_URL).responseJSON {response in
            let result = response.result.value
           // print("RESPOOOSSNSEE\(result)")
            
            if let weatherData = result as? Dictionary<String, AnyObject> {
                
                if let data = weatherData["response"] as? [Dictionary<String, AnyObject>] {
                   //print("RESPOOOSSNSEE\(data)")
        
                    if let periods = data[0]["periods"] as? [Dictionary<String, AnyObject>] {
                      
                    //Get the JSON DATA for the the current temperature
                        if let currentTemp = periods[0]["avgTempF"] as? Double {
                            self.getCurrentTemp = String(Int(currentTemp))
                            self.tempLabel.text = "\(Int(currentTemp))°"
                        }
                        
                   //Get the JSON Data for the weatherType
                        if let currentWeatherType = periods[0]["weatherPrimary"] as? String {
                            self.weatherTypeLabel.text = currentWeatherType
                            self.imageLabel.backgroundColor = nil
                        }
                    
                    
                  //Create dictionaries and add it to the arrays from the JSON Data
                        for dicts in periods{
                         
                            let condition = dicts["weatherPrimary"] as? String
                            
                            if  condition == "Scattered Blowing Snow" || condition=="Snow" || condition=="Isolated Wintry Mix" {
                                self.weatherDescriptionArray.append("Snow")
                                
                            }else if  condition=="Rain" || condition=="Scattered Showers" {
                                self.weatherDescriptionArray.append("Rain")
                                
                            }else {
                                if let condition = condition {
                                    self.weatherDescriptionArray.append(condition)
                                    
                                }
                            }
                            
                //Populate the array with the forecast dicts
                            let forecast = WeatherData(dataDicts: dicts)
                            self.forecasts.append(forecast)
                            
                            print("WeatherData\(dicts)")
                        }
                        
                        print("IMAGEEESS_-------\(self.weatherDescriptionArray)")
                 
                    //Remove Today's forecast
                        self.forecasts.removeFirst()
                        
                   //Remove todays forecast and replace current weather image with the value
                        let firstItem = self.weatherDescriptionArray.removeFirst()
                        self.imageLabel.image = UIImage(named: firstItem)
                        
                    //Reload the data in the tableView
                        self.tableView.reloadData()
                        
                    }
                
                }
            
            }
            
        }
        
    }

    
    
    @IBAction func selectedTempType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            
        //Convert to fahrenheit when the fahrenheit segment is selected
            tempLabel.text = "\(celciusToFahrenheit(cel: getCurrentTemp))°"
            getCurrentTemp = celciusToFahrenheit(cel: getCurrentTemp)
            print(celciusToFahrenheit(cel: getCurrentTemp))
        
       //Convert the forecast to fahrenheit
            for forecast in forecasts {
                forecast._maxTemp = celciusToFahrenheit(cel: forecast._maxTemp)
                forecast._minTemp = celciusToFahrenheit(cel: forecast._minTemp)
                tableView.reloadData()
            }
            print(0)
        case 1:
            
        //Convert to Celcius when the celcius segment is selected
            tempLabel.text = "\(fahrenheitToCelcius(fah: getCurrentTemp))°"
            getCurrentTemp = fahrenheitToCelcius(fah: getCurrentTemp)
            print(fahrenheitToCelcius(fah: getCurrentTemp))
       
        //Convert the forecast to Celcius
            for forecast in forecasts {
                forecast._maxTemp = fahrenheitToCelcius(fah: forecast._maxTemp)
                forecast._minTemp = fahrenheitToCelcius(fah: forecast._minTemp)
                tableView.reloadData()
            }
            
            print(1)
        default:
            print("nothing")
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count\(forecasts.count)")
        return forecasts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as? WeatherDataCell {
            let forecastData = forecasts[indexPath.row]
            cell.fillCell(forecast: forecastData)
            cell.forecastImage.image = UIImage(named: weatherDescriptionArray[indexPath.row])
            return cell
        }else{
            return WeatherDataCell()
        }
        
    }
    
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
   
}

