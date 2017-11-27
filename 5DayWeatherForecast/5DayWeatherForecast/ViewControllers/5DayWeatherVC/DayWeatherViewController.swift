//
//  5DayWeatherViewController.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 25/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class DayWeatherViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    //MARK: Variables
    var city: City!
    let session = Session.shared
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.alpha = 0.0
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        spinner.startAnimating()
        OpenWeatherRepository.getWeatherByCityName(city.name) { (success) in
            
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.tableView.reloadData()
                
                if !success {
                    let alertController = UIAlertController(title: "Atenção!", message: "Nenhum resultado foi encontrado", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    return
                }
                if self.session.fiveDaysWeatherList.count > 0 {
                    if let icon = self.session.fiveDaysWeatherList.first?.icon {
                        self.weatherIconImageView.setImageWith(url: "http://openweathermap.org/img/w/\(icon).png")
                    }
                    
                    if let cityName = self.session.fiveDaysWeatherList.first?.cityName {
                        self.cityNameLabel.text = cityName
                    }
                    
                    if let tmpWeather = self.session.fiveDaysWeatherList.first?.temp {
                        self.temperatureLabel.text = "\(tmpWeather)'"
                    }
                    
                    UIView.animate(withDuration: 0.2, animations: { 
                        self.contentView.alpha = 1.0
                    })
                }
            }
        }
    }
    
    //MARK: Setups
    private func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = 48
        
        let nib = UINib(nibName: "DayWeatherTableViewCell", bundle: nil)
        
        tableView.register(nib, forCellReuseIdentifier: "DayWeatherTableViewCell")
    }
}

//MARK: UITableView Extension
extension DayWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.fiveDaysWeatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherTableViewCell") as! DayWeatherTableViewCell
        
        let weather = session.fiveDaysWeatherList[indexPath.row]
        cell.weatherIcon.setImageWith(url: "http://openweathermap.org/img/w/\(weather.icon!).png")
        cell.weekDayLabel.text = handleDate(indexPath.row).dayOfWeek()
        cell.tempMaxLabel.text = "\(weather.tempMax!)'"
        cell.tempMinLabel.text = "\(weather.tempMin!)'"

        return cell
    }
    
    //Helper
    func handleDate(_ index:Int ) -> Date {
        
        let date = Date()
        if index > 0 {
            let nextDay = Calendar.current.date(byAdding: .day, value: index, to: date)
            return nextDay!
        }
        return date
    }
}

//MARK:Date Extension
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
