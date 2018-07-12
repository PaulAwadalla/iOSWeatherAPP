//
//  forecastWeatherData.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/11/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit
import Alamofire

class forecastWeatherData {
    //data encapsulation
    var _cityName: String!
    var _dateAndTime: String!
    var _weatherCondition: String!
    var _currentSmallTemp: String!
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    
    var dateAndTime: String {
        if _dateAndTime == nil {
            _dateAndTime = ""
        }
        return _dateAndTime
    }
    
    var weatherCondition: String {
        if _weatherCondition == nil {
            _weatherCondition = ""
        }
        return _weatherCondition
    }
    
    var currentSmallTemp: String {
        if _currentSmallTemp == nil {
            _currentSmallTemp = ""
        }
        return _currentSmallTemp
    }
    
    
    init(weatherDict: Dictionary<String, AnyObject>) {
        
        
        
        if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
            if let temp = main["temp"] as? Double {
                let kelvintoFarenheit = (temp * (9/5) - 459.67)
                let totalKelvinToFarenheit = Double(round(10 * kelvintoFarenheit/10))
                let tempPlusFarenheit = String(format: "%.0f", totalKelvinToFarenheit)
                let tempString = "\(tempPlusFarenheit)º"
                self._currentSmallTemp = tempString
               
                
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherCondition = main.capitalized
            }
        }
        if let date = weatherDict["dt"] as? Double {
            let unixConvertDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE, HH:mm"
            dateFormatter.timeStyle = .full
            self._dateAndTime = unixConvertDate.timeOfday()
            }
        
        }
    
    }


extension Date {
    func timeOfday() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, HH:mm"
        return dateFormatter.string(from: self)
        
        }
    }



