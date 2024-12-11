//
//  APIService.swift
//  NYTimes_Demo
//
//  Created by Carlos Vazquez on 09/12/24.
//
import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case decodingError
    case networkError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "The URL is invalid."
        case .decodingError: return "Failed to decode the response."
        case .networkError(let message): return message
        }
    }
}

protocol URLSessionProtocol: Sendable {
    func dataTask(
        with url: URL,
        completionHandler: @escaping @Sendable (
            Data?,
            URLResponse?,
            Error?
        ) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

final class APIService {
    private let session: URLSessionProtocol
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(
        from urlString: String,
        apiKey: String,
        responseType: T.Type,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: apiKey)]
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.networkError("No data received.")))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
