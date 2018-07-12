//
//  currentWeatherData.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/10/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit
import Alamofire

class currentWeatherData {
    //data encapsulation
    var _cityName: String!
    var _humidity: String!
    var _pressure: String!
    var _windSpeed: String!
    var _directionPoint: String!
    var _rainlevel: String!
    var _weatherType: String!
    var _currentTemp: String!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var humidity: String {
        if _humidity == nil {
            _humidity = ""
        }
        return _humidity
    }
    
    var pressure: String {
        if _pressure == nil {
            _pressure = ""
        }
        return _pressure
    }
    
    var wind: String {
        if _windSpeed == nil {
            _windSpeed = ""
        }
        return _windSpeed
    }
    
    var direction: String {
        if _directionPoint == nil {
            _directionPoint = ""
        }
        return _directionPoint
    }
    
    var rainMh: String {
        if _rainlevel == nil {
            _rainlevel = "0mm"
        }
        return _rainlevel
    }
    
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func downloadWeatherData(completed: @escaping DownloadComplete){
        // to tell alamofire where to download the data
        
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dictionary = result.value as? Dictionary<String, AnyObject>{
                // getting the city name
                if let name = dictionary["name"] as? String {
                    self._cityName = name.capitalized
                   // print(self.cityNameone ?? "No City")
                    }
                // getting the weatherType
                if let weather = dictionary["weather"] as? [Dictionary<String, AnyObject>]{
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                       // print(self.weatherTypeone ?? "No WeatherType")
                        }
                    }
                // getting current Temperature
                if let main = dictionary["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvintoFarenheit = (currentTemperature * (9/5) - 459.67)
                        let totalKelvinToFarenheit = Double(round(10 * kelvintoFarenheit/10))
                        let tempPlusFarenheit = String(format: "%.0f", totalKelvinToFarenheit)
                        let tempString = "\(tempPlusFarenheit)ºF"
                        self._currentTemp = tempString
                        //print(self.currentTempone ?? "no temp")
                        
                        }
                    }
                // getting the wind speed
                if let windy = dictionary["wind"] as? Dictionary<String, AnyObject> {
                    if let currentWind = windy["speed"] as? Double{
                        let windMPH = (currentWind * 2.2369)
                        let roundWindMPH = Double(round(10 * windMPH/10))
                        let windPrecentage = String(format: "%.1f", roundWindMPH)
                        let windString = "\(windPrecentage)mph"
                        self._windSpeed = windString
                        //print(self.windSpeed ?? "no speed")
                        }
                    }
                //getting the rainfall levels
                if let rainFall = dictionary["rain"] as? Dictionary<String, AnyObject> {
                    if let currentRainFall = rainFall["3h"] as? Double{
                        let rainFallDecimal = String(format: "%.2f",currentRainFall)
                        let rainFallString = "\(rainFallDecimal)mm"
                        self._rainlevel = rainFallString
                       // print(self.rainlevel ?? "no rain")
                    }
                }
                //getting pressure levels
                if let pressureLevels = dictionary["main"] as? Dictionary<String, AnyObject>{
                    if let currentPressureLevels = pressureLevels["pressure"] as? Double{
                        let pressureLevelNumber = String(format: "%.0f",currentPressureLevels)
                        let pressureLevelString = "\(pressureLevelNumber)hPa"
                        self._pressure = pressureLevelString
                       
                        }
                    }
                //getting humdity levels
                if let humidityLevels = dictionary["main"] as? Dictionary<String, AnyObject>{
                    if let currentHumidityLevels = humidityLevels["humidity"] as? Double {
                        let humidityLevelNumber = String(format: "%.0f", currentHumidityLevels)
                        let humidityLevelString = "\(humidityLevelNumber)%"
                        self._humidity = humidityLevelString
                       
                        }
                    }
                //getting direction
                if let windDirections = dictionary["wind"] as? Dictionary<String, AnyObject>{
                    if let currentWindDirections = windDirections["deg"] as? Double {
                       let changeFormDegress = directionFromDegrees(degrees: currentWindDirections)
                        self._directionPoint = changeFormDegress
                       
                        
                        }
                    }
                }
            completed()
        }
        func directionFromDegrees(degrees : Double) -> String {

            let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
            let i: Int = Int((degrees + 11.25)/22.5)
            return directions[i % 16]
        }
    }
    
    
    
    
}
