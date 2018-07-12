//
//  Location.swift
//  ios_weather_app_strv
//
//  Created by Paul Awadalla on 7/12/18.
//  Copyright © 2018 Paul Awadalla. All rights reserved.
//

import CoreLocation
import Foundation

class location {
    static var sharedinstance = location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
