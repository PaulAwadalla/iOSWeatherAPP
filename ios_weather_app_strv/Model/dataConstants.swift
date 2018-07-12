//
//  dataConstants.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/10/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import Foundation

let mainURL = "https://api.openweathermap.org/data/2.5/weather?"
let lattiude = "lat="
let longitude = "&lon="
let appID = "&appid="
let apiKey = "9fb335dff6ba9621c0d68e5ec779d3aa"

//this tells us when the download is complete.
typealias DownloadComplete = () -> ()

let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=9fb335dff6ba9621c0d68e5ec779d3aa"

let lat = location.sharedinstance.latitude!
let lon = location.sharedinstance.longitude!

let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=9fb335dff6ba9621c0d68e5ec779d3aa"

