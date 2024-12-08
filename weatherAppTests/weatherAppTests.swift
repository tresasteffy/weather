//
//  weatherAppTests.swift
//  weatherAppTests
//
//  Created by apple on 07/12/24.
//

import XCTest
@testable import weatherApp

struct WeatherResponse: Codable {
    let list: [WeatherDetails]
}

struct WeatherDetails: Codable, Identifiable {
    let id: UUID = UUID()
    let main: Main
    let weather: [WeatherCondition]
}

struct Main: Codable {
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

protocol NetworkServiceProtocol {
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
}

class MockNetworkService: NetworkServiceProtocol {
    var mockWeatherData: WeatherResponse?
    var mockError: Error?

    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        if let error = mockError {
            completion(.failure(error))
        } else if let weatherData = mockWeatherData {
            completion(.success(weatherData))
        } else {
            completion(.failure(NSError(domain: "TestError", code: -1, userInfo: nil)))
        }
    }
}

final class WeatherAppTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var viewModel: WeatherViewModel!

    override func setUpWithError() throws {
        mockNetworkService = MockNetworkService()
        viewModel = WeatherViewModel()
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
        viewModel = nil
    }

    func testFetchWeatherSuccess() throws {
        // Given
        let mockWeatherData = WeatherResponse(
            list: [
                WeatherDetails(
                    main: Main(temp: 22.0, temp_min: 18.0, temp_max: 25.0, humidity: 60),
                    weather: [WeatherCondition(description: "Sunny", icon: "01d", main: "Clear")]
                )
            ]
        )
        mockNetworkService.mockWeatherData = mockWeatherData

        viewModel.city = "San Francisco"
        let expectation = self.expectation(description: "Weather data fetched")
        
        // Fetch weather and notify expectation when done
        viewModel.fetchWeather()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()  // Make sure to fulfill the expectation
        }

        waitForExpectations(timeout: 2, handler: nil)

        // Then
        XCTAssertEqual(viewModel.currentWeather?.main.temp, 14.87)
        XCTAssertEqual(viewModel.forecast.count, 5)
        XCTAssertNil(viewModel.errorMessage)
    }




    func testFetchWeatherFailure() throws {
        // Given
        let mockError = NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock network error"])
        mockNetworkService.mockError = mockError

        viewModel.city = "InvalidCity"
        let expectation = self.expectation(description: "Weather fetch failed")
        viewModel.fetchWeather()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)

        // Then
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, "Server Error: city not found")
        XCTAssertNil(viewModel.currentWeather)
        XCTAssertTrue(viewModel.forecast.isEmpty)
    }





}
