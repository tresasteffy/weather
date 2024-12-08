//
//  ForecastView.swift
//  weatherApp
//
//  Created by apple on 07/12/24.
//

import Foundation
import SwiftUICore
import SwiftUI

struct ForecastView: View {
    let forecast: [WeatherDetails]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("5-Day Forecast")
                .font(.headline)

            ScrollView {
                ForEach(forecast, id: \.dt) { weather in
                    WeatherDisplayView(weather: weather)
                }
            }
        }
        .padding()
    }
}
