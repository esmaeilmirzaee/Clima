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

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
  
  // Constants
  let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
  let APP_ID = "894f130231441d5e5b0c37596bc79c58"
  
  //TODO: declare instance variables here
  let locationManager = CLLocationManager()
  let weatherDataModel = WeatherDataModel()
  
  // Pre-linked IBOutlets
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var switchButton: UISwitch!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  
  @IBAction func fahrenheitToCelsius(_ sender: UISwitch) {
    if sender.isOn {
      weatherDataModel.temperature = weatherDataModel.baseTemperature
      updateUIWithWeatherData()
    } else {
      let fahrenheit = (weatherDataModel.baseTemperature - 32) * 5 / 9
      weatherDataModel.temperature = fahrenheit
      print(fahrenheit)
      updateUIWithWeatherData()
    }
  }
  
  @IBAction func goToChangeCityViewControllerButtonPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "changeCityName", sender: self)
  }
  
  //MARK: - Networking
  func getWeatherData(url: String, parameters: [String : String]) {
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
      print(response)
      if response.result.isSuccess {
        print("Success! The data has been collected.")
        if let weatherJSON: JSON = JSON(response.result.value) {
          print(weatherJSON)
          self.updateWeatherData(json: weatherJSON)
        }
      } else {
        print("\(String(describing: response.result.error))")
        self.cityLabel.text = "Connection Issue 🥺"
      }
    }
  }
  
  //MARK: - JSON parsing
  //updateWeatherData
  func updateWeatherData(json: JSON) {
    if let temperature = json["main"]["temp"].double {
      weatherDataModel.baseTemperature = Int(temperature - 273.15)
      weatherDataModel.temperature = weatherDataModel.baseTemperature
      weatherDataModel.city = json["name"].stringValue
      weatherDataModel.condition = json["weather"][0]["id"].intValue
      weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
      updateUIWithWeatherData()
    } else {
      cityLabel.text = "Weather's unavilable."
    }
  }
  
  //MARK: - UI Updates
  //updateUIWithWeatherData
  func updateUIWithWeatherData() {
    cityLabel.text = weatherDataModel.city
    temperatureLabel.text = "\(weatherDataModel.temperature)"
    weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
  }
  
  //MARK: - Location manager delegate methods
  //didUpdateLocation method
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if (locations[locations.count - 1]).horizontalAccuracy > 0 {
      let location = locations[locations.count - 1]
      locationManager.stopUpdatingLocation()
      locationManager.delegate = nil
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
  func userEnteredANewCityName(city: String) {
    locationManager.stopUpdatingLocation()
    locationManager.delegate = nil
    let params = ["q" : city, "appid" : APP_ID]
    switchButton.setOn(true, animated: true)
    getWeatherData(url: WEATHER_URL, parameters: params)
  }
  
  //Prepare for segue method
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "changeCityName" {
      let destinationVC = segue.destination as! ChangeCityViewController
      destinationVC.delegate = self
      
    }
  }
}
