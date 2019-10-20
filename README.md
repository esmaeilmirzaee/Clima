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
10.