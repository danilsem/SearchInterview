//
//  WeatherCell.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import UIKit

class WeatherCell: UITableViewCell {

    static let identifier = "WeatherCell"
    static let nib = UINib(nibName: "WeatherCell", bundle: nil)
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityStatusLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with weather: WeatherCityResponse) {
        cityNameLabel?.text = "\(weather.name)"
        cityStatusLabel?.text = "\(weather.weather.first?.weatherDescription ?? "")"
        cityTempLabel?.text = "\(weather.main.temp)C"
    }
    
}
