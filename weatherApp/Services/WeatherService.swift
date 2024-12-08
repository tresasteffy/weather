//
//  WeatherService.swift
//  weatherApp
//
//  Created by apple on 07/12/24.
//

import Foundation

import Foundation

class BaseURL {
    static let baseURL = "https://api.openweathermap.org/data/2.5"
    static let apiKey = "5585f62b857e083fe4460daa9407d253"
    
    static func getURL(for endpoint: String, with city: String) -> String {
        return "\(baseURL)\(endpoint)?q=\(city)&appid=\(apiKey)&units=metric"
    }
}


class WeatherService {
    private let networkService = NetworkService()

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        let urlString = BaseURL.getURL(for: "/forecast", with: city)
        guard let url = URL(string: urlString) else {
            completion(.failure(.networkError("Invalid URL")))
            return
        }

        networkService.fetchData(from: url, responseType: WeatherResponse.self, completion: completion)
    }
}

