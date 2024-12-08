//
//  ContentView.swift
//  weatherApp
//
//  Created by apple on 07/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchView(viewModel: viewModel)

                if let currentWeather = viewModel.currentWeather {
                    WeatherDisplayView(weather: currentWeather)
                }

                if !viewModel.forecast.isEmpty {
                    ForecastView(forecast: viewModel.forecast)
                }

                Spacer()
            }
            .navigationTitle("Weather App")
            .padding()
        }
    }
}
