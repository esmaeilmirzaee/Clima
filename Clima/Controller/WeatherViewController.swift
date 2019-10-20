//
//  WeatherViewController.swift
//  Clima
//
//  Created by Esmaeil MIRZAEE on 10/20/19.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    // Constants
    let WEATHER_URL = ""
    let APP_ID = ""
    
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
    }
    
    //MARK: - Networking
}
