//
//  Session.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 26/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class Session {
    
    static let shared = Session()
    private init() {
//        SearchRepository.getSearchableItemBy(entry: <#T##String#>, completion: <#T##([City]) -> Void#>)
    }
    
    //cache
    var fiveDaysWeatherList: [Weather] = []

}
