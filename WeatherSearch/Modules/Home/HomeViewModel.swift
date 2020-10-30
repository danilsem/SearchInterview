//
//  HomeViewModel.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import Foundation

protocol HomeViewModelProtocol: class {
    var weatherCount: Int { get }
    var weatherCities: [WeatherCityResponse] { get set }
    func loadStandartCities(completion: (() -> ())?)
    func loadSearchCity(for city: String, completion: (() -> ())?)
}

// Я не знал можно ли использовать стороние библиотеки
// поэтому не использовал RxSwift и пришлось заморачиваться с completion в функциях

class HomeViewModel: HomeViewModelProtocol {
    var weatherCities: [WeatherCityResponse] = []
    let standartCityNames = ["Moscow", "New York", "London", "Tokyo", "Seoul", "Orsk", "Madrid", "Berlin", "Paris", "Incheon"]
    
    var weatherCount: Int {
        weatherCities.count
    }
    
    let service: WeatherService
    
    init(service: WeatherService = .shared) {
        self.service = service
    }
    
    func loadStandartCities(completion: (() -> ())? = nil) {
        self.weatherCities = []
        standartCityNames.forEach { (city) in
            service.fetchWeather(for: city) { [weak self] (result) in
                switch result {
                case .success(let response):
                    self?.weatherCities.append(response)
                    completion?()
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func loadSearchCity(for city: String, completion: (() -> ())? = nil) {
        if city != "" {
            self.weatherCities = []
            
            service.fetchWeather(for: city) { (result) in
                switch result {
                case .success(let response):
                    self.weatherCities.append(response)
                    completion?()
                case .failure(_):
                    break
                }
            }
        }
    }
}
