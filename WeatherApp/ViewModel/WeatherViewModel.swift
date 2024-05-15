//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Erick Quintanar on 5/13/24.
//

import Foundation
import UIKit

class WeatherViewModel {
    
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    //MARK: Calling Fetch Weather Data from Network Manager using a URL and some Data from the View Controller
    func fetchWeatherData(units: String, location: Location, completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        
        let networkManager = NetworkManager()
        let apiKey = Constants.ApiKey.apiKey
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&appid=\(apiKey)&units=\(units)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        networkManager.fetchWeatherData(from: url, completion: completion)
    }
    
    //MARK: Calling Fetch Image Data from Network Manager using the Image Name from the Fetch Weather Data to display the image on the view controller
    func fetchImage(from imageName:String , completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        let urlString = "https://openweathermap.org/img/wn/\(imageName)@2x.png"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        networkManager.fetchImageData(from: url) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkError.invalidImageData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
