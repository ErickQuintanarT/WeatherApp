//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Erick Quintanar on 5/13/24.
//

import Foundation

//MARK: Weather Model
struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double // Default Temp Unit in Kelvin
    let feels_like: Double // Default Temp Unit in Kelvin
    let temp_min: Double // Default Temp Unit in Kelvin
    let temp_max: Double // Default Temp Unit in Kelvin
    
    let pressure: Int
    let humidity: Int
    let sea_level: Int?
    let grnd_level: Int?
}

struct Wind: Codable {
    let speed: Double //Default Unit in meter/sec
    let deg: Int
    let gust: Double? //Default Unit in meter/sec
}

struct Rain: Codable {
    let oneH: Double?
    let threeH: Double?
}

struct Clouds: Codable {
    let all: Int
}

struct Sys: Codable {
    let type: Int?
    let id: Int?
    let country: String?
    let sunrise: Int //Sunrise time, unix, UTC
    let sunset: Int //Sunset time, unix, UTC
}


//MARK: Example JSON API Response
/*
 
 {
   "coord": {
     "lon": 10.99,
     "lat": 44.34
   },
   "weather": [
     {
       "id": 501,
       "main": "Rain",
       "description": "moderate rain",
       "icon": "10d"
     }
   ],
   "base": "stations",
   "main": {
     "temp": 298.48,
     "feels_like": 298.74,
     "temp_min": 297.56,
     "temp_max": 300.05,
     "pressure": 1015,
     "humidity": 64,
     "sea_level": 1015,
     "grnd_level": 933
   },
   "visibility": 10000,
   "wind": {
     "speed": 0.62,
     "deg": 349,
     "gust": 1.18
   },
   "rain": {
     "1h": 3.16
   },
   "clouds": {
     "all": 100
   },
   "dt": 1661870592,
   "sys": {
     "type": 2,
     "id": 2075663,
     "country": "IT",
     "sunrise": 1661834187,
     "sunset": 1661882248
   },
   "timezone": 7200,
   "id": 3163858,
   "name": "Zocca",
   "cod": 200
 }
 
 */
