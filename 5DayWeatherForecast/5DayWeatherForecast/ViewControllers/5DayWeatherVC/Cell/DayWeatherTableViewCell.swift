//
//  DayWeatherTableViewCell.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 26/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class DayWeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }   
}
