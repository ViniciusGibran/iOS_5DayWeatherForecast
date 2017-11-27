//
//  SearchRepository.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 25/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

struct City {
    var id: Int!
    var name: String!
    var country: String!
    var coord: (longitude: Double?, latitude: Double?)
    
    init() {}
}

class SearchRepository: NSObject {
    
    static func getLocationBy(_ input: String, completion: @escaping (_ returnList: [City]) -> Void) {
        
        
        var returnList: [City] = []
        
        let url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=(cities)&language=us&key=AIzaSyCNoBwPWniY3LIrtSOMsgjhefTHs7icrfw"
        
        if let http = Foundation.URL(string: url) {
            if let data = try? Data(contentsOf: http) {
                
                guard let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                    return
                    
                }
                guard let localData = json as? NSDictionary else {
                    return
                }
                
                if let array = localData["predictions"] as? NSArray {
                    
                    var city = City()
                    for cityArray in (array as? [[String:Any]])! {
                        
                        if let infoArray = cityArray["structured_formatting"] as? [String: Any] {
                            if let cityName = infoArray["main_text"] as? String {
                                city.name = cityName
                                returnList.append(city)
                            }
                        }
                    }
                    
                    completion(returnList)
                }
            }
        }
    }
    
    static func getSearchableItemsByJSON(completion: @escaping ([City]) -> Void) {
        
        if let path = Bundle.main.url(forResource: "citylist", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String: Any]]
                
                var city = City()
                var cityList: [City] = []
                for result in jsonResult {
                    
                    city.id = result["id"] as? Int
                    city.name = result["name"] as? String
                    city.country = result["country"] as? String
                    
                    if let coord = result["coord"] as? [String: Any] {
                        city.coord.latitude = coord["lat"] as? Double
                        city.coord.longitude = coord["lat"] as? Double
                    }
                    
                    cityList.append(city)
                }
                completion(cityList)
                
            } catch {
                //handle
            }
        }
    }
    
    
}









