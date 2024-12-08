//
//  Constants.swift
//  weatherApp
//
//  Created by apple on 08/12/24.
//

import Foundation
import SwiftUICore
class Constants {
    struct Texts {
        static let enterCityName = "Enter city name"
        static let getWeather = "Get Weather"
        static let pleaseEnterCityName = "Please enter a city name"
        static let temp = "Temp: "
        static let humidity = "Humidity: "
        static let min = "Min: "
        static let max = "Max: "
        static let weather = "Weather"
        static let conditionNotAvailable = "Condition not available"
    }
    
    struct Colors {
        static let buttonEnabled = Color.blue
        static let buttonDisabled = Color.gray
        static let errorMessageColor = Color.red
        static let backgroundStart = Color.blue.opacity(0.8)
        static let backgroundEnd = Color.purple.opacity(0.8)
        static let textColor = Color.white
    }
    
    struct Padding {
        static let standard: CGFloat = 16
        static let button: CGFloat = 10
        static let textField: CGFloat = 8
    }
    
    struct IconNames {
        static let sun = "sun.max.fill"
        static let cloudSun = "cloud.sun.fill"
        static let cloud = "cloud.fill"
        static let cloudRain = "cloud.rain.fill"
        static let cloudHeavyRain = "cloud.heavy.rain.fill"
        static let cloudSunRain = "cloud.sun.rain.fill"
        static let cloudBolt = "cloud.bolt.fill"
        static let snowflake = "snowflake"
        static let cloudFog = "cloud.fog.fill"
    }
}
