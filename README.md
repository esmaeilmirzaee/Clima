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
  * `stopUpdatingLocation()` and set `locationManager.delegate` to `nil`
15. write function `didFailWithError`
  - print error
  - inform user by updating cityLabel with 'Location's unavailable'
16. call `startUpdatingLocation` function in `viewDidLoad` function
17. create a params dictionary variable and save latitude, longitude and appid in it.
18. cal getWeatherData and provide `url` and `parameters` for it
19. import `Alamofire` and `SwiftyJSON`
20. complete `Alamofire.request(url, method: .get, parameters: parameters).responseJSON {}`
21. then check the if `response.result` is success or failure
22. save the `response.result.value` in an unwraped variable as a JSON type
23. create a class named `WeatherDataModel` and declare variables as the following list

|**let/var**|**name**|**type**|**value**|
|----|----|----|:----:|
|var|temperature|int|0|
|var|condition|int|0|
|var|city|String|""|
|var|weatherIconName|String|""|

24. also add a function named `updateWeatherIcon` which implements a `switch` statement to convert code to an icon.
25. call the `updateUIWithWeatherData` function and set the available data.
26. **Navigating Data Between View Controller**s. In `ChangeCityViewController` declare a protocol and define `userEnteredANewCityName` function that requires a string value. **NOTE** *definition must be before the class definition.*
27. declare an optional `delegate` variable of the created protocol. **NOTE** *by convention the name of this variable is `delegate`.*
28. in `getWeatherPressed` function, assign the text of text field to a variable and if it's not `nil` call the `userEneteredANewCityName` function by passing city name on `delegate` variable.
29. dismiss the current view controller by calling `self.dismiss(animated: true, completion: nil)` function.
30. in `WeatherViewController`, confirm to inherite `ChangeCityDelegate`.
31. implement `goToChangeCityViewControllerButtonPressed` by calling `performSegue(withIdentifie: "identifier's name", sender: self)`.
32. implement change city view delegate method, define a dictionary variable and store `"q"` as a city name and app_id. Then call `getWeatherData`.
33. override `prepare` function for segue and check if the `segue.identifier` is equal to segue's name then create `segue.destination` a `viewcontroller` variable `as!` `ChangeCityViewController` and then assign its delegate to `self`
