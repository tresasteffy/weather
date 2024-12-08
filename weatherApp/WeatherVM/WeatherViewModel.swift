import Foundation

class WeatherViewModel: ObservableObject {
    @Published var city: String = ""
    @Published var currentWeather: WeatherDetails?
    @Published var forecast: [WeatherDetails] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService()
    private let lastCityKey = "LastCity"
    private let networkService: NetworkServiceProtocol

    init() {
        self.networkService = NetworkService()
        if let savedCity = UserDefaults.standard.string(forKey: lastCityKey) {
            city = savedCity
        }
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        
        if let savedCity = UserDefaults.standard.string(forKey: lastCityKey) {
            city = savedCity
        }
    }
    
    func fetchWeather() {
        UserDefaults.standard.setValue(city, forKey: lastCityKey)
        
        guard !city.isEmpty else { return }
        
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(for: city) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.currentWeather = response.list.first
                    self.forecast = Array(response.list.prefix(5))
                case .failure(let error):
                    self.handleError(error.description)
                }
            }
        }
    }
    
    private func handleError(_ message: String) {
        self.errorMessage = message
        self.currentWeather = nil
        self.forecast = []
        UserDefaults.standard.removeObject(forKey: lastCityKey)
    }
}
