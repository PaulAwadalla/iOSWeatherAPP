//
//  forecastVC.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/5/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class forecastVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var currentLocationCity: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var loadforecastData: forecastWeatherData!
    var forecasts = [forecastWeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.downloadForecastData {
           
        }
        
        
    }
    
    
    func downloadForecastData(completed: @escaping DownloadComplete){
        
        Alamofire.request(forecastWeatherURL).responseJSON { response in
            let result = response.result
            if let dictionary = result.value as? Dictionary<String, AnyObject> {
                
                
                if let list = dictionary["list"] as? [Dictionary<String, AnyObject>]{
                    for obj in list {
                        let forecastWeather = forecastWeatherData(weatherDict: obj)
                        self.forecasts.append(forecastWeather)
                        
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? weatherCell {
            
            let forecastWeather = forecasts[indexPath.row]
            cell.confgureCell(loadforcastData: forecastWeather)
             return cell
        }else {
            return weatherCell()
        }
       
    }

}

    
  
    
   



