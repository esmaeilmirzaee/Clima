//
//  WeatherViewController.swift
//  Clima
//
//  Created by Esmaeil MIRZAEE on 10/20/19.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    // Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "894f130231441d5e5b0c37596bc79c58"
    
    //TODO: declare instance variables here
    let locationManager = CLLocationManager()
    
    // Pre-linked IBOutlets
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Networking
    func getWeatherData(url: String, parameters: [String : String]) {
        
    }
    
    //MARK: - UI update
    
    //MARK: - Location manager delegate methods
    //didUpdateLocation method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations[locations.count - 1]).horizontalAccuracy > 0 {
            let location = locations[locations.count - 1]
            locationManager.stopUpdatingLocation()
            print("Lon: \(locations[locations.count - 1].coordinate.longitude); Lat: \(locations[locations.count - 1].coordinate.latitude)")
            let params: [String : String] = [
                "lat":"\(location.coordinate.latitude)",
                "lon":"\(location.coordinate.longitude)",
                "appid":APP_ID]
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
        
    }
    //didFailWithError method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location's unavailable 😫"
    }
    //MARK: - Change city delegate methods
    //userEnteredANewCityName method
    //Prepare for segue method
}
