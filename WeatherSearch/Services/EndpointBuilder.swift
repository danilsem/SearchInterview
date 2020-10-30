//
//  EndpointBuilder.swift
//  WeatherSearch
//
//  Created by Admin on 30.10.2020.
//

import Foundation

class EndpointBuilder {
    static func build(for endpoint: WeatherEndpoint, query: [String: String]?) -> URL? {
        guard var components = URLComponents(string: endpoint.rawValue) else { return nil }
        switch endpoint {
        case .searchCity:
            if let query = query {
                var queryItems: [URLQueryItem] = []
                for item in query {
                    let queryItem = URLQueryItem(name: item.key, value: item.value)
                    queryItems.append(queryItem)
                }
                components.queryItems = queryItems
            }
            
            return components.url
        }
    }
}
