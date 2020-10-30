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
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func loadSearchCity(for city: String, completion: (() -> ())? = nil) {
        if city == "" {
            return
        }
        
        self.weatherCities = []
        
        service.fetchWeather(for: city) { (result) in
            switch result {
            case .success(let response):
                self.weatherCities.append(response)
                completion?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
