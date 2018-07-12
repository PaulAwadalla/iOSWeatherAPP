//
//  weatherCell.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/12/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit

class weatherCell: UITableViewCell {
    @IBOutlet weak var weathePic: UIImageView!
    @IBOutlet weak var timeAndDay: UILabel!
    @IBOutlet weak var weatherCondtion: UILabel!
    @IBOutlet weak var tempOfDay: UILabel!
    
    func confgureCell(loadforcastData: forecastWeatherData){
        tempOfDay.text = loadforcastData.currentSmallTemp
        timeAndDay.text = loadforcastData.dateAndTime
        weatherCondtion.text = loadforcastData.weatherCondition
        weathePic.image = UIImage(named: loadforcastData.weatherCondition)
    }

    

}
