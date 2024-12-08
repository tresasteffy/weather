//
//  WeatherModel.swift
//  weatherApp
//
//  Created by apple on 07/12/24.
//

import Foundation

struct WeatherResponse: Codable {
    let city: City
    let list: [WeatherDetails]
}

struct City: Codable {
    let name: String
}

struct WeatherDetails: Codable {
    let dt: Int
    let main: WeatherMain
    let weather: [WeatherCondition]
}

struct WeatherMain: Codable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}

struct WeatherCondition: Codable {
    let description: String
    let icon: String  
    let main: String
}
