//
//  TextField.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 26/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding(value: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: value, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}
