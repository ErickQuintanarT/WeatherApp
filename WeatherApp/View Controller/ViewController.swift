//
//  ViewController.swift
//  WeatherApp
//
//  Created by Erick Quintanar on 5/13/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var shortDescription: UILabel!
    @IBOutlet weak var lowAndHighTemp: UILabel!
    @IBOutlet weak var windAndSpeedDir: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    let viewModel = WeatherViewModel()
    let settingsViewDelegate = SettingsViewController()
    
    var selectedUnit = "Imperial"
    var segmentSelected = 0
    
    let defaultLocation = Location(lat: 34.0194704, lon: -118.4912273)
    var customLocation = Location(lat: 0, lon: 0)
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: settingsViewDelegate.notification, object: nil)
        
        cityName.text = "--"
        currentTemperature.text = "--°"
        shortDescription.text = "--"
        lowAndHighTemp.text = "Low: --°  Hight: --°"
        windAndSpeedDir.text = "Wind: -- (--)"
        
        // Location Manager
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation() // start location update
        locationManager.distanceFilter = 100 // update location after 100 meter
        
        fetchWeatherData()
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let data = notification.userInfo?["pickerData"] as? String {
            selectedUnit = data
        }
        
        if let data = notification.userInfo?["segmentData"] as? Int {
            segmentSelected = data
        }
        fetchWeatherData()
    }
        
    func fetchWeatherData() {
        activity.isHidden = false
        activity.startAnimating()
        
        var location = Location(lat: 0, lon: 0)
        if segmentSelected == 0 {
            location = defaultLocation
        } else {
            location = customLocation
        }
        
        viewModel.fetchWeatherData(units: selectedUnit, location: location) { [weak self] result in
            switch result {
            case .success(let data):
                
                print(data)
//                DispatchQueue.main.async {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Delay on Dispath to Simulated Low Networt to see Activity Indicator

                    self?.cityName.text = "\(data.name)"
                    self?.currentTemperature.text = "\(data.main.temp)°"
                    
                    guard let description = data.weather.first?.description else {
                        return
                    }
                    self?.shortDescription.text = "\(description)".capitalized
                    self?.lowAndHighTemp.text = "Low:  \(data.main.temp_min)°  High: \(data.main.temp_max)°"
                    self?.windAndSpeedDir.text = "Wind: \(data.wind.speed) (\(data.wind.deg))"
                    
                    guard let imageString = data.weather.first?.icon else {
                        return
                    }
                    self?.fetchImageData(imageName: imageString)
                    self?.activity.stopAnimating()
                    self?.activity.isHidden = true
                    
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    func fetchImageData(imageName: String) {
        viewModel.fetchImage(from: imageName) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.image.image = image
                }
            case .failure(let error):
                print("Error fetching image: \(error)")
            }
        }
    }
    
    func showAlert(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0] // The first location in the array
        customLocation = Location(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude)
    }
}

//MARK: CLLocationManagerDelegate
extension AppDelegate: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .denied: // Setting option: Never
            print("LocationManager didChangeAuthorization denied")
        case .notDetermined: // Setting option: Ask Next Time
            print("LocationManager didChangeAuthorization notDetermined")
        case .authorizedWhenInUse: // Setting option: While Using the App
            print("LocationManager didChangeAuthorization authorizedWhenInUse")
        case .authorizedAlways: // Setting option: Always
            print("LocationManager didChangeAuthorization authorizedAlways")
        case .restricted: // Restricted by parental control
            print("LocationManager didChangeAuthorization restricted")
        default:
            print("LocationManager didChangeAuthorization")
        }
    }
}
