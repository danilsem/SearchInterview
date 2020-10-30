//
//  DetailWeatherViewController.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var viewModel: DetailWeatherViewModelProtocol!
    
    init(viewModel: DetailWeatherViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews() {
        countryLabel?.text = "Country: \(viewModel.weather.sys.country)"
        windLabel?.text = "Wind speed: \(viewModel.weather.wind.speed)m/s"
        statusLabel.text = "\(viewModel.weather.weather.first?.main ?? "")"
        self.navigationItem.title = "\(viewModel.weather.name)"
    }
    
}
