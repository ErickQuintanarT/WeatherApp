//
//  NetworkManagerProtocol.swift
//  WeatherApp
//
//  Created by Erick Quintanar on 5/13/24.
//

import Foundation
import UIKit

//MARK: Network Manager Protocol
protocol NetworkManagerProtocol {
    func fetchWeatherData<T: Codable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void)
    func fetchImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
