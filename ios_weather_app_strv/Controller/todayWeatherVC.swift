//
//  todayWeatherVC.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/5/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class todayWeatherVC: UIViewController, CLLocationManagerDelegate  {
    
    @IBOutlet weak var weatherTypeImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var humdityLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    
    var locationAndTemp: DatabaseReference!
    let locationManger = CLLocationManager()
    var currentLocation: CLLocation!
    
    var loadCurrentWeather: currentWeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        locationManger.startMonitoringSignificantLocationChanges()
        
        loadCurrentWeather = currentWeatherData()
        locationAndTemp = Database.database().reference()
        
        
        
    }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            loactionAuthStatus()
        }
    
    func addLocationAndTemp(){
        let key = locationAndTemp.childByAutoId().key
        let data = ["id":key,
            "Current location": loadCurrentWeather.cityName,
            "Current Temperature": loadCurrentWeather.currentTemp,
            "Current Wind Speed": loadCurrentWeather.wind,
            "Current Wind Direction": loadCurrentWeather.direction
            ]
        locationAndTemp.child(key).setValue(data)
    }
        
        func loactionAuthStatus() {
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                currentLocation = locationManger.location
                location.sharedinstance.latitude = currentLocation.coordinate.latitude
                location.sharedinstance.longitude = currentLocation.coordinate.longitude
                loadCurrentWeather.downloadWeatherData {
                    //setting uo UI to download data
                    self.updateTodayUI()
                    self.addLocationAndTemp()
                    
                }
                
            }
            else {
                locationManger.requestWhenInUseAuthorization()
                loactionAuthStatus()
            }
        }

    @IBAction func shareButton(_ sender: Any) {
        let activityShare = UIActivityViewController(activityItems: ["Weather Data form Paul's App_:","City Name:",loadCurrentWeather.cityName,",","Weather Condition:",loadCurrentWeather.weatherType,",","Current Tempeature:", loadCurrentWeather.currentTemp,"."], applicationActivities: nil)
        activityShare.popoverPresentationController?.sourceView = self.view
        self.present(activityShare, animated: true, completion: nil)
    }
    
    

    func updateTodayUI() {
        locationLabel.text = loadCurrentWeather.cityName
        weatherTypeLabel.text = loadCurrentWeather.weatherType
        currentTempLabel.text = "\(loadCurrentWeather.currentTemp)"
        weatherTypeImage.image = UIImage(named: loadCurrentWeather.weatherType)
        windLabel.text = loadCurrentWeather.wind
        humdityLabel.text = loadCurrentWeather.humidity
        precipitationLabel.text = loadCurrentWeather.rainMh
        pressureLabel.text = loadCurrentWeather.pressure
        directionLabel.text = loadCurrentWeather.direction
        
    }

}
