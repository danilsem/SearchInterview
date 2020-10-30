//
//  WeatherService.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import Foundation

class WeatherService {
    static let shared: WeatherService = WeatherService()
    
    private init() { }
    
    var appId: String {
        "b479b53e46d92a2dc9dd3e9f38b26f45"
    }

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherCityResponse, Error>) -> ()) {
        guard let url = EndpointBuilder.build(for: .searchCity, query: [
            "q": city,
            "appid": appId,
            "units": "metric"
        ]) else {
            completion(.failure(WeatherError.badUrl))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(WeatherError.apiError))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(WeatherError.apiError))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(WeatherCityResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
        }.resume()
    }
}

enum WeatherEndpoint: String {
    case searchCity = "https://api.openweathermap.org/data/2.5/weather" // q=Orsk&appid=b479b53e46d92a2dc9dd3e9f38b26f45
}

enum WeatherError: Error {
    case decodeError
    case apiError
    case badUrl
}
