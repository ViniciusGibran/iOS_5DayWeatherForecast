//
//  HomeViewController.swift
//  5DayWeatherForecast
//
//  Created by Vinicius Gibran on 25/11/17.
//  Copyright © 2017 Vinicius Gibran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var labelResultInfo: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Variables
    //    weak var delegate: SearchDelegate?
    lazy var resultItemList: [City] = []
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let navigation = navigationController?.navigationBar {
            navigation.setBackgroundImage(UIImage(), for: .default)
            navigation.shadowImage = UIImage()
            navigation.isTranslucent = true
        }
        
        setupTableView()
        textField.setPadding(value: 20)
        textField.delegate = self
        view.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if resultItemList.isEmpty {
            spinner.startAnimating()
            DispatchQueue.global().async(execute: { 
                self.bindInitialData()
            })
        }
    }
    
    //MARK: - Setups
    func setupTableView() {
        automaticallyAdjustsScrollViewInsets = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchResultTableViewCell")
    }
    
    internal func setLabelResultInfoWith(text: String) {
        labelResultInfo.isHidden = tableView.isHidden ? false : true
        labelResultInfo.text = text
    }
    
    //MARK: Helper
    func bindInitialData(){
        SearchRepository.getSearchableItemsByJSON(completion: { (resultItems) in
            self.resultItemList = resultItems
            DispatchQueue.main.async {
                if self.resultItemList.count == 0 {
                    self.tableView.isHidden = true
                    self.labelResultInfo.isHidden = false
                    self.spinner.stopAnimating()
                    self.textField.becomeFirstResponder()
                    return
                }
                self.tableView.isHidden = false
                self.labelResultInfo.isHidden = true
                self.textField.isUserInteractionEnabled = true
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        })
    }
}

//MARK: TableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        
        if resultItemList.count > 0 {
            cell.searchResult = resultItemList[indexPath.row].name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let city = resultItemList[indexPath.row]
        let dayWeatherVC = DayWeatherViewController(nibName: "DayWeatherViewController", bundle: nil)
        dayWeatherVC.city = city
        self.navigationController?.pushViewController(dayWeatherVC, animated: true)
    }
}

//MARK: TextField Delegate
extension HomeViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }
        
        let inputLength = textField.text!.characters.count
        let inputString = textField.text!.replacingOccurrences(of: " ", with: "%20")
        
        if inputLength > 1 && inputLength < 10 {
            spinner.startAnimating()
            SearchRepository.getLocationBy(inputString) { (resultList) in
                if resultList.count > 0 {
                    self.resultItemList = resultList
                    self.tableView.reloadData()
                }else {
                    self.resultItemList.removeAll()
                    self.tableView.reloadData()
                }
                self.spinner.stopAnimating()
            }
        }else {
            resultItemList.removeAll()
            tableView.reloadData()
        }
        
        return true
    }
}








