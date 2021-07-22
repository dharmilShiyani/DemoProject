//
//  LTAP.swift
//  LTAP
//
//  Created by Wdev3 on 17/02/21.
//

import UIKit

class LTAP: NSObject {
    static let sharedInstance = LTAP()
    
    var currentUser: UserModel?
    var deviceToken = ""
    var DeviceType = "1"
    var navigationBackgroundImage: UIImage?
    
    var selectedUserType : userRole = .User
    var languageType : String = "1"
    
    var isShowMedicationAddedTable : Bool = false
    
    var tabbarHeight : CGFloat = 0.0
    
    var systemOSVersion : String = UIDevice.current.systemVersion
    
    var version : String = Bundle.main.releaseVersionNumber ?? ""
    var build : String = Bundle.main.buildVersionNumber ?? ""
    var deviceID : String = UIDevice.current.identifierForVendor?.uuidString ?? ""
    var userRole : String = "2"

    var localTimeZoneIdentifier: String { return TimeZone.current.identifier }
    
    var AppVersion : String = "\(Bundle.main.releaseVersionNumber ?? "") \(Bundle.main.buildVersionNumber ?? "")"
    
    var currentAddressString : String = ""
    
    func getAddressFromLatLong(lat: Double,long: Double,complation : @escaping (_ address : String,_ country : String,_ state : String,_ city : String,_ street : String,_ zipcode : String) -> Void )  {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: lat , longitude: long)
        var address : String = ""
        var countryname : String = ""
        var statename : String = ""
        var cityname : String = ""
        var streetname : String = ""
        var zipcode : String = ""
        var locstreet : String = ""
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            //print("Response GeoLocation : \(placemarks)")
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
            
            if placeMark != nil {
                // Country
                if let country = placeMark.country {
                    //print("Country :- \(country)")
                    countryname = country
                    // City
                    
                }
                
                if let city = placeMark.subAdministrativeArea {
                    //print("City :- \(city)")
                    cityname = city
                    
                }
                
                // State
                if let state = placeMark.administrativeArea{
                    print("State :- \(state)")
                    statename = state
                }
                // Street
                if let street = placeMark.thoroughfare{
                    //print("Street :- \(street)")
                    streetname = placeMark.subLocality ?? ""
                    
                }
                
                // ZIP
                if let zip = placeMark.postalCode{
                    //print("ZIP :- \(zip)")
                    zipcode = zip
                    
                }
                
                // Location name
                if let locationName = placeMark?.name {
                    //print("Location Name :- \(locationName)")
                    locstreet = locationName
                }
                
                if locstreet != "" {
                    address = locstreet
                }
                if streetname != "" {
                    address = "\(address == "" ? "" : "\(address),")\(streetname)"
                }
                
                if cityname != "" {
                    address = "\(address == "" ? "" : "\(address),")\(cityname)"
                }
                
                if countryname != "" {
                    address = "\(address == "" ? "" : "\(address),")\(countryname)"
                }
            }
            
            complation(address,countryname,statename,cityname,streetname,zipcode)
        })
    }
    
    func getArrayOfYear() -> [String] {
        let startingYear : Int = 1900
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        let currentYear = Int(yearString) ?? startingYear
        
        var arrYear = [String]()
        for i in stride(from: startingYear, to: currentYear, by: 1) {
            arrYear.append(String(i))
        }
        print(arrYear)
        arrYear.append(yearString)
        return arrYear
    }
    
    func getCurrentYear() -> String {
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        
        return yearString
    }
}
