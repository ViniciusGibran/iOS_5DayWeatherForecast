//
//  OpenWeatherRepository.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 25/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class OpenWeatherRepository {
    
    static func getWeatherByCityName(_ cityName: String, completion: @escaping (_ success: Bool) -> Void) {
        
        let city = cityName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let string = "http://api.openweathermap.org/data/2.5/find?q=\(city)&units=metric&appid=c8431a4bf7a6732a5d83aef4f3de2c7c"
        
        if let url = URL(string: string) {
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    return completion(false)
                }
                
                if data != nil {
                    let jsonResult = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    
                    
                    if jsonResult != nil {
                        
                        var resultList: [Weather] = []
                        if let itemList = jsonResult!["list"] as? NSArray {
                            
                            for item in itemList {
                                if let itemJSON = item as? [String: Any] {
                                    if let weather = Weather(JSON: itemJSON) {
                                        resultList.append(weather)
                                    }
                                }
                            }
                        }
                        
                        if resultList.count > 0 {
                            Session.shared.fiveDaysWeatherList = resultList
                            return completion(true)
                        }
                        
                        completion(false)
                    }
                }
                }.resume()
        }
    }
}
