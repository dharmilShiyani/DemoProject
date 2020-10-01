//
//  AppDelegate.swift
//  Infallible Care
//
//  Created by APPLE on 06/05/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import GoogleMaps
import GooglePlaces
import CoreLocation
import SVProgressHUD
import Starscream
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var sideMenu = MenuVC()
    let locationManager = CLLocationManager()
    var isMessageShow = false
    var userRole = String()
    var Socket: WebSocket!
    var isScoketConnect = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        GMSServices.provideAPIKey(kGoogleAPIKey)
        GMSPlacesClient.provideAPIKey(kGoogleAPIKey)
        self.connectSocket()
        
        //LOCATION
        setLocationManager()
        locationManager.delegate = self
        LocationHandler.shared.getLocationUpdates { (locationManger, location) -> (Bool) in
            lat_currnt = location.coordinate.latitude
            long_currnt = location.coordinate.longitude
            return true
        }
        
        //Notification
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            // Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        // Configure for Remote Notification
        self.registerForRemoteNotifications()
        application.registerForRemoteNotifications()
        
        //USER REDIRECT
        if ModelUserData.getUserDataFromUserDefaults().token == "" {
            self.setTutorial()
        }
        else if ModelUserData.getUserDataFromUserDefaults().role == "3"{ // CareGiver
            self.userRole = "3"
            if ModelUserData.getUserDataFromUserDefaults().profileStatus == "0" {
                let vc  = loadVC(strStoryboardId: SB_LOGIN, strVCId: idCompleteProfile2) as! CompleteProfile2
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                kAppDelegate.window!.rootViewController = nav
                kAppDelegate.window?.makeKeyAndVisible()
            }
            else{
                kAppDelegate.setDashBoard()
            }
        }
        else{
            self.userRole = "2"
            if ModelUserData.getUserDataFromUserDefaults().profileStatus == "0" {
                let vc  = loadVC(strStoryboardId: SB_LOGIN, strVCId: idCompleteProfileVC) as! CompleteProfileVC
                let nav = UINavigationController(rootViewController: vc)
                nav.isNavigationBarHidden = true
                kAppDelegate.window!.rootViewController = nav
                kAppDelegate.window?.makeKeyAndVisible()
            }else{
                self.setDashBoard()
            }
        }
         
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        kAppDelegate.connectSocket()

    }
    func setTutorial() {

        let vc  = loadVC(strStoryboardId: SB_LOGIN, strVCId: idTutorialVC) as! TutorialVC
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        kAppDelegate.window!.rootViewController = nav
        kAppDelegate.window?.makeKeyAndVisible()
    }
    
    func setDashBoard() {
        
        let vc = kMainStoryBoard.instantiateViewController(withIdentifier: "NavigationController")
        let mainViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        mainViewController.rootViewController = vc
        
        mainViewController.setup(type: UInt(4))
        self.window!.rootViewController = mainViewController
        self.window?.makeKeyAndVisible()
    }
    
}

//MARK:- Location Manager
extension AppDelegate : CLLocationManagerDelegate {
    func getIpLocation(completion: @escaping(NSDictionary?, Error?) -> Void)
    {
        let url     = URL(string: "http://ip-api.com/json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        showLoaderHUD(strMessage: "")
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler:
            { (data, response, error) in
                
                
                DispatchQueue.main.async
                    {
                        if let content = data
                        {
                            do
                            {
                                if let object = try JSONSerialization.jsonObject(with: content, options: .allowFragments) as? NSDictionary
                                {
                                    completion(object, error)
                                    SVProgressHUD.dismiss()
                                }
                                else
                                {
                                    // TODO: Create custom error.
                                    completion(nil, nil)
                                    SVProgressHUD.dismiss()
                                }
                            }
                            catch
                            {
                                // TODO: Create custom error.
                                completion(nil, nil)
                                SVProgressHUD.dismiss()
                            }
                        }
                        else
                        {
                            completion(nil, error)
                            SVProgressHUD.dismiss()
                        }
                }
        }).resume()
    }
    func setLocationManager()
    {
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        locationManager.stopUpdatingLocation()
        let locValue:CLLocationCoordinate2D = manager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0)
        lat_currnt = locValue.latitude
        long_currnt = locValue.longitude
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        locationManager.startUpdatingLocation()
    }
    
    //this method will be called each time when a user change his location access preference.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            
        }
        
        print(CLLocationManager.authorizationStatus())
        switch(CLLocationManager.authorizationStatus()) {
        case .notDetermined:
            print("No determinded")
        case  .restricted, .denied:
            print("No access")
            let okAction = UIAlertAction(title: "Setting", style: .default, handler: { (alert: UIAlertAction!) in
                
                
                if let url = URL(string: "\(UIApplication.openSettingsURLString)&path=LOCATION/\("com.app.splitez.demo")") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
                LocationHandler.shared.getLocationUpdates { (locationManager, location) -> (Bool) in
                    lat_currnt = location.coordinate.latitude
                    long_currnt = location.coordinate.longitude
                    USERDEFAULTS.set(lat_currnt, forKey: kLat_Curr)
                    USERDEFAULTS.set(long_currnt, forKey: kLong_Curr)
                    
                    return true
                    
                }
            })
            let cancelAction = UIAlertAction(title:  "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) in
                
                self.getIpLocation { (response, error) in
                    
                    let lat = response?["lat"] as? Double
                    let long = response?["lon"] as? Double
                    
                    let FinalLat:String = String(format:"%f", lat ?? 0)
                    let FinalLog:String = String(format:"%f", long ?? 0)
                    lat_currnt = Double(FinalLat) as! Double
                    long_currnt = Double(FinalLog) as! Double
                    USERDEFAULTS.set(lat_currnt, forKey: kLat_Curr)
                    USERDEFAULTS.set(long_currnt, forKey: kLong_Curr)
                }
            })
            
            let alertController = UIAlertController(title: "Allow Location Access", message: "permission to access your location.", preferredStyle: .alert)
            
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            // Present the controller
            let tab =  UIApplication.shared.delegate?.window!?.rootViewController as? UITabBarController
            
            if tab != nil {
                let nav = tab?.selectedViewController as? UINavigationController
                nav?.present(alertController, animated: true, completion: nil)
            } else if let nav =  UIApplication.shared.delegate?.window!?.rootViewController as? UINavigationController {
                //                UIApplication.inputViewController()?.present(nav, animated: true, completion: nil)
                nav.present(alertController, animated: true, completion: nil)
            }
            
        case .authorizedAlways, .authorizedWhenInUse:
            
            print("Granted")
            
            LocationHandler.shared.getLocationUpdates { (locationManager, location) -> (Bool) in
                lat_currnt = location.coordinate.latitude
                long_currnt = location.coordinate.longitude
                USERDEFAULTS.set(lat_currnt, forKey: kLat_Curr)
                USERDEFAULTS.set(long_currnt, forKey: kLong_Curr)
                
                
                return true
            }
            
        @unknown default:
            fatalError()
        }
    }
}

//MARK:- Remote Notification Methods
extension AppDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { (data) -> String in return String(format: "%02.2hhx", data) }.joined()
        print(token)
        UserDefaults.standard.set(token, forKey: UD_Device_Token)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for notifications: \(error.localizedDescription)")
    }
    
    fileprivate func extractedFunc() {
        //iOS 9
        let type: UIUserNotificationType = [UIUserNotificationType.badge, UIUserNotificationType.alert, UIUserNotificationType.sound]
        let setting = UIUserNotificationSettings(types: type, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(setting)
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func registerForRemoteNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if let error = error {
                    print("D'oh: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        if granted {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                        else {
                            //Do stuff if unsuccessful...
                        }
                    }
                }
            }
        } else {
            extractedFunc()
        }
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}


//MARK:- WebSocket Delegate Method
extension AppDelegate : WebSocketDelegate {
    
    func connectSocket() {
        
        let request = URLRequest(url: URL(string: WS_URL)!)
        Socket = WebSocket(request: request)
        Socket.delegate = self
        Socket.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
        switch event {
        case .connected(let headers):
            // isConnected = true
            print("websocket is connected: \(headers)")
            let token = ModelUserData.getUserDataFromUserDefaults().token
            
            if token != "" {
                kAppDelegate.isScoketConnect = true
                let dictionary = ["token":ModelUserData.getUserDataFromUserDefaults().token ?? "",
                                  "hookMethod": "registration"]
                if let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
                    let theJsonText = String(data: theJSONData, encoding: .utf8)
                    print("JSON String = \(theJsonText!)")
                    Socket.write(string: "\(theJsonText!)")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: kSocketConnect), object: nil, userInfo: [:])

                }
            }
            
        case .disconnected(let reason, let code):
            //isConnected = false
            print("websocket is disconnected: \(reason) with code: \(code)")
            kAppDelegate.connectSocket()
            kAppDelegate.isScoketConnect = false
        case .text(let string):
            print("Received text: \(string)")
            
        case .binary(let data):
            print("Received data: \(data.count)")
            
        case .ping(_):
            break
            
        case .pong(_):
            break
            
        case .viablityChanged(let viablity):
            print(viablity)
            break
            
        case .reconnectSuggested(_):
            kAppDelegate.connectSocket()
            break
            
        case .cancelled:
            // isConnected = false
            kAppDelegate.connectSocket()
            print("Not Conected")
            kAppDelegate.isScoketConnect = false
            break
        case .error(let error):
            //isConnected = false
            // handleError(error)
            kAppDelegate.connectSocket()
            print("Not Conected, error: \(String(describing: error))")
            kAppDelegate.isScoketConnect = false
            break
        }
    }
}
