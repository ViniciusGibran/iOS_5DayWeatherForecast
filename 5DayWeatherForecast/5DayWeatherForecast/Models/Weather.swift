//
//  Weather.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 26/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class Weather: Mappable {

    var humidity: Int!
    var pressure: Int!
    var temp: Int!
    var tempMax: Int!
    var tempMin: Int!
    var cityName: String!
    var weatherDscription: String!
    var icon: String!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        cityName <- map["name"]
        
        if let weatherList = map.JSON["weather"] as? NSArray {
            for weather in weatherList {
                if let json = weather as? [String: Any] {
                    weatherDscription = json["description"] as? String
                    icon = json["icon"] as? String
                }
            }
        }
        
        if let json = map.JSON["main"] as? [String: AnyObject] {
            humidity = json["humidity"] as? Int
            pressure = json["pressure"] as? Int
            temp = json["temp"] as? Int
            tempMax = json["temp_max"] as? Int
            tempMin = json["temp_min"] as? Int
        }
        
        
    }
}
