//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Erick Quintanar on 5/13/24.
//

import Foundation

public class NetworkManager: NetworkManagerProtocol {
    
    func fetchImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) { // Get Image data
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.noData))
                }
                return
            }
            completion(.success(data))
        }.resume()
    }
    
    func fetchWeatherData<T: Codable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) { // Get Weather Data
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
}

enum NetworkError: Error {
    case noData
    case invalidImageData
}
