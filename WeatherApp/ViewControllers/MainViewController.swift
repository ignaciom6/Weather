//
//  ViewController.swift
//  WeatherApp
//
//  Created by Ignacio Mariani on 31/05/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let kError = "Error"
    private let kOK = "OK"
    private let viewModel = WeatherViewModel()
    private var dailyWeatherArr: [DailyWeather] = []

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weatherDesc: UILabel!
    @IBOutlet weak var wind: UILabel!
    @IBOutlet weak var dewPoint: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var dailyWeatherTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dailyWeatherTable.dataSource = self
        
        viewModel.cityNameModel.bind { [weak self] cityName in
            self?.cityName.text = cityName
        }
        
        viewModel.tempModel.bind { [weak self] temp in
            self?.temp.text = temp
        }
        
        viewModel.date.bind { [weak self] date in
            self?.date.text = date
        }
        
        viewModel.weatherDesc.bind { [weak self] weatherDesc in
            self?.weatherDesc.text = weatherDesc
        }
        
        viewModel.windSpeed.bind { [weak self] wind in
            self?.wind.text = wind
        }
        
        viewModel.dewPoint.bind { [weak self] dewP in
            self?.dewPoint.text = dewP
        }
        
        viewModel.humidity.bind { [weak self] humidity in
            self?.humidity.text = humidity
        }
        
        viewModel.error.bind { [weak self] error in
            if !error.isEmpty {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: self?.kError, message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: self?.kOK, style: .default, handler: { (UIAlertAction) in
                        self?.dismiss(animated: true, completion: nil)
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        viewModel.dailyWeather.bind { [weak self] dailyWeather in
            self?.dailyWeatherArr = dailyWeather ?? []
            self?.dailyWeatherTable.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeatherArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyWeatherTable.dequeueReusableCell(withIdentifier: "dailyCell", for: indexPath) as! DailyTableViewCell
        
        let dailyWeather = self.dailyWeatherArr[indexPath.row]
        
        cell.day.text = FormatterUtilities.getDay(unix: dailyWeather.dt)
        cell.maxTemp.text = FormatterUtilities.getFormattedTemp(fullTemp: dailyWeather.temp.max)
        cell.minTemp.text = FormatterUtilities.getFormattedTemp(fullTemp: dailyWeather.temp.min)
        
        return cell
    }
}

