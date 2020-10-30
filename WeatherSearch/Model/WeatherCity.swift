//
//  WeatherCity.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import Foundation

// MARK: - Welcome
struct WeatherCityResponse: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: WeatherMain
    let visibility: Int
    let wind: Wind
    let dt: Int
    let sys: WeatherSystem
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - WeatherMain
struct WeatherMain: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - WeatherSystem
struct WeatherSystem: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed, deg: Double
}

