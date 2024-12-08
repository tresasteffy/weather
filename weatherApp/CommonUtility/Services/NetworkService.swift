//
//  NetworkService.swift
//  weatherApp
//
//  Created by apple on 07/12/24.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData<T: Decodable>(
        from url: URL,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}


extension URLSession: URLSessionProtocol {}


class NetworkService: NetworkServiceProtocol {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchData<T: Decodable>(
        from url: URL,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                if let data = data, let apiError = self.decodeError(from: data) {
                    completion(.failure(.serverError(apiError)))
                } else {
                    completion(.failure(.httpError(httpResponse.statusCode)))
                }
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError(error.localizedDescription)))
            }
        }.resume()
    }

    private func decodeError(from data: Data) -> String? {
        struct APIError: Codable {
            let cod: String
            let message: String
        }
        let decoded = try? JSONDecoder().decode(APIError.self, from: data)
        return decoded?.message
    }
}


enum NetworkError: Error, CustomStringConvertible {
    case networkError(String)
    case invalidResponse
    case httpError(Int)
    case noData
    case decodingError(String)
    case serverError(String)

    var description: String {
        switch self {
        case .networkError(let message):
            return "Network Error: \(message)"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .noData:
            return "No data received"
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .serverError(let message):
            return "Server Error: \(message)"
        }
    }
}
