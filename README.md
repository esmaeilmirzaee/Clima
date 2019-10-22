# Clima App

The entire process to create current application is as follows:

1. Create a simple single view application for iOS
2. Design the UI
3. Close the application
4. Install `cocoapods.org` unless you did in the past
5. cd to your application workspace
5. run `pod setup --verbose`
6. run `pod init`
7. open your `Podfile` with your editor
8. Pods
  8.1 uncomment the specification
  8.2 add required pods
    8.2.1 pod 'SwiftyJSON'
    8.2.2 pod 'SVProgressHUD'
    8.2.3 pod 'Alamofire'
  8.3 save 
  8.4 run `pod install`
9. open *.xcoprojectworks
10. let WeatherViewController to inherit from `CLLocationManagerDelegate`
11. define `locationManger = CLLocationManager`
12. in viewDidLoad() 
  12.1. set `locationManager` to `self`
  12.2. set `locationManager.desiredAccuracy` to your preference or requirement
  12.3. set `locationManager.requestWhenInUseAuthorization()`
13. open `Info.plist`
  13.1. add `Privacy - Location When In Use Description`
  13.2. add `Privacy - Location Usage Discription` 
  13.3. we use [Open Weather Map](openweathermap.org) via `http` add the following
  ```XML
    <key>NSAppTransportSecurity</key>
    <dict>
      <key>NSExceptionDomains</key>
      <dict>
        <key>openweathermap.org</key>
        <dict>
           <key>NSIncludesSubdomains</key>
           <true/>
           <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
           <true/>
        </dict>
      </dict>
    </dict>
  ```
14. write function `didUpdateLocations`
  * check last location in `locations` variable
  * if it owns higher value than 0 then get 'longitude' and 'latitude' variable
  * stopUpdatingLocation()
15. write function `didFailWithError`
  - print error
  - inform user by updating cityLabel with 'Location's unavailable'
16. call `startUpdatingLocation` function in `viewDidLoad` function
17. create a params dictionary variable and save latitude, longitude and appid in it.
18. cal getWeatherData and provide `url` and `parameters` for it
19. import `Alamofire` and `SwiftyJSON`
20. complete `Alamofire.request(url, method: .get, parameters: parameters).responseJSON {}`
21. 