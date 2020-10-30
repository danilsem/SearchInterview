//
//  DetailWeatherViewModel.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import Foundation

protocol DetailWeatherViewModelProtocol: class {
    var weather: WeatherCityResponse { get set }
}

class DetailWeatherViewModel: DetailWeatherViewModelProtocol {
    var weather: WeatherCityResponse
    
    init(weather: WeatherCityResponse) {
        self.weather = weather
    }
}
