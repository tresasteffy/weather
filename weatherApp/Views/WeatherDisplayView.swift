import SwiftUI

struct WeatherDisplayView: View {
    let weather: WeatherDetails

    var body: some View {
        VStack {
            HStack {
                if let icon = weather.weather.first?.icon {
                    Image(systemName: iconName(for: icon))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding(5)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(weather.weather.first?.main ?? Constants.Texts.weather)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Constants.Colors.textColor)
                    Text(weather.weather.first?.description.capitalized ?? Constants.Texts.conditionNotAvailable)
                        .font(.footnote)
                        .foregroundColor(Constants.Colors.textColor)
                }
                Spacer()
            }

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text("\(Constants.Texts.temp)\(weather.main.temp, specifier: "%.1f")°C")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Constants.Colors.textColor)
                    
                    Spacer()
                    
                    Text("\(Constants.Texts.humidity)\(weather.main.humidity)%")
                        .font(.subheadline)
                        .foregroundColor(Constants.Colors.textColor)
                }
                
                HStack {
                    Text("\(Constants.Texts.min)\(weather.main.temp_min, specifier: "%.1f")°C")
                        .font(.subheadline)
                        .foregroundColor(Constants.Colors.textColor)
                    
                    Spacer()
                    
                    Text("\(Constants.Texts.max)\(weather.main.temp_max, specifier: "%.1f")°C")
                        .font(.subheadline)
                        .foregroundColor(Constants.Colors.textColor)
                }
            }
            .padding(8)

        }
        .padding(12)
        .frame(maxWidth: 300)
        .background(LinearGradient(gradient: Gradient(colors: [Constants.Colors.backgroundStart, Constants.Colors.backgroundEnd]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(12)
        .shadow(radius: 8)
        .padding(.horizontal)
    }

    func iconName(for icon: String) -> String {
        switch icon {
        case "01d", "01n": return Constants.IconNames.sun
        case "02d", "02n": return Constants.IconNames.cloudSun
        case "03d", "03n": return Constants.IconNames.cloud
        case "04d", "04n": return Constants.IconNames.cloudRain
        case "09d", "09n": return Constants.IconNames.cloudHeavyRain
        case "10d", "10n": return Constants.IconNames.cloudSunRain
        case "11d", "11n": return Constants.IconNames.cloudBolt
        case "13d", "13n": return Constants.IconNames.snowflake
        case "50d", "50n": return Constants.IconNames.cloudFog
        default: return Constants.IconNames.cloud
        }
    }
}
