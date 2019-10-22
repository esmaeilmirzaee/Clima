//
//  WeatherDataModel.swift
//  Clima
//
//  Created by Esmaeil MIRZAEE on 10/22/19.
//  Copyright © 2019 Esmaeil MIRZAEE. All rights reserved.
//

import UIKit

class WeatherDataModel {
  // Model variables
  var temperature: Int = 0
  var condition: Int = 0
  var city: String = ""
  var weatherIconName: String = ""
  
  // Turning a condition code into the name of the weather condition image
  func updateWeatherIcon(condition: Int) -> String {
    switch condition {
    case 0...300:
      return ""
    case 301...600:
      return ""
    default:
      <#code#>
    }
  }
}
