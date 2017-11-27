//
//  SearchResultTableViewCell.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 25/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var searchResult: String = "" {
        didSet{
            resultLabel.text = searchResult
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
