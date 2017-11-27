//
//  ImageView.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 26/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

public extension UIImageView {
    
    public func setImageWith(url: String,
                             placeholderImage: Image? = nil,
                             optionsInfo: KingfisherOptionsInfo? = nil,
                             progressBlock: DownloadProgressBlock? = nil,
                             completionHandler: CompletionHandler? = nil) /*-> RetrieveImageTask?*/ {
        
        if let url = URL(string: url) {
            
            _ = self.kf.setImage(with: url, placeholder: placeholderImage, options: optionsInfo, progressBlock: progressBlock, completionHandler: completionHandler)
        } else {
            debugPrint("<UIImageView.setUrl> invalid url \(url)")
        }
    }
}
