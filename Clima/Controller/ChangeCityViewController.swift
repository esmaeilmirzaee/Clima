//
//  ChangeCityViewController.swift
//  Clima
//
//  Created by Esmaeil MIRZAEE on 10/20/19.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//

import UIKit

//the protocol delclaration
protocol ChangeCityDelegate {
  func userEnteredANewCityName(city: String)
}

class ChangeCityViewController: UIViewController {
  
  // Declare the delegate variable
  var delegate: ChangeCityDelegate?
  
  // This is the pre-linked IBOutlets to the text field
  @IBOutlet weak var changeCityTextField: UITextField!
  
  // This is the IBAction that gets called when the user taps on the "Get Weather"
  @IBAction func getWeatherPressed(_ sender: AnyObject) {
    //1 Get the city name the user entered in the text field
    if let cityName = changeCityTextField.text {
      
      //2 If we have a delegate set, call the method userEnteredANewCityName
      delegate?.userEnteredANewCityName(city: cityName)
      
      //3 Dismiss the change city view controller to go back to the WeatherViewController
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func backButtonPressed(_ sender: AnyObject) {
    self.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
}
