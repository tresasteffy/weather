//
//  SearchView.swift
//  weatherApp
//
//  Created by apple on 07/12/24.
//
import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(spacing: Constants.Padding.standard) {
            TextField(Constants.Texts.enterCityName, text: $viewModel.city)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(Constants.Padding.textField)
            
            Button(action: {
                if !viewModel.city.isEmpty {
                    viewModel.fetchWeather()
                } else {
                    viewModel.errorMessage = Constants.Texts.pleaseEnterCityName
                }
            }) {
                Text(Constants.Texts.getWeather)
                    .padding(Constants.Padding.button)
                    .background(viewModel.city.isEmpty ? Constants.Colors.buttonDisabled : Constants.Colors.buttonEnabled)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.city.isEmpty)
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(Constants.Colors.errorMessageColor)
            }
        }
        .padding()
    }
}
