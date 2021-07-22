//
//  UserModel.swift
//  OmApp
//
//  Created by KETAN SODVADIYA on 24/01/19.
//  Copyright © 2019 OM App. All rights reserved.
//

import UIKit
typealias FailureBlock = (_ statuscode: String,_ error: String, _ customError: ErrorType) -> Void

final class UserModel: NSObject,NSCoding {
    
    var createdDate : String
    var createdDatetimestamp : String
    var email : String
    var fillpassword : String
    var firstName : String
    var forgotCode : String
    var id : String
    var image : String
    var joined : String
    var lastName : String
    var password : String
    var phone : String
    var phoneCode : String
    var professionalInformation : ModelProfessionalInformation!
    var profileStatus : String
    var profileimage : String
    var role : String
    var status : String
    var thumbprofileimage : String
    var token : String
    var updatedDate : String
    var username : String
    var verificationCode : String
    
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(dictionary: [String:Any]){
        createdDate = dictionary["createdDate"] as? String ?? ""
        createdDatetimestamp = dictionary["createdDatetimestamp"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        fillpassword = dictionary["fillpassword"] as? String ?? ""
        firstName = dictionary["firstName"] as? String ?? ""
        forgotCode = dictionary["forgotCode"] as? String ?? ""
        id = dictionary["id"] as? String ?? ""
        image = dictionary["image"] as? String ?? ""
        joined = dictionary["joined"] as? String ?? ""
        lastName = dictionary["lastName"] as? String ?? ""
        password = dictionary["password"] as? String ?? ""
        phone = dictionary["phone"] as? String ?? ""
        phoneCode = dictionary["phone_code"] as? String ?? ""
        if let professionalInformationData = dictionary["professionalInformation"] as? [String:Any]{
            professionalInformation = ModelProfessionalInformation(fromDictionary: professionalInformationData)
        }
        profileStatus = dictionary["profileStatus"] as? String ?? ""
        profileimage = dictionary["profileimage"] as? String ?? ""
        role = dictionary["role"] as? String ?? ""
        status = dictionary["status"] as? String ?? ""
        thumbprofileimage = dictionary["thumbprofileimage"] as? String ?? ""
        token = dictionary["token"] as? String ?? ""
        updatedDate = dictionary["updatedDate"] as? String ?? ""
        username = dictionary["username"] as? String ?? ""
        verificationCode = dictionary["verificationCode"] as? String ?? ""
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        dictionary["createdDate"] = createdDate
        
        dictionary["createdDatetimestamp"] = createdDatetimestamp
        
        dictionary["email"] = email
        
        dictionary["fillpassword"] = fillpassword
        
        dictionary["firstName"] = firstName
        
        dictionary["forgotCode"] = forgotCode
        
        dictionary["id"] = id
        
        dictionary["image"] = image
        
        dictionary["joined"] = joined
        
        dictionary["lastName"] = lastName
        
        dictionary["password"] = password
        
        dictionary["phone"] = phone
        
        if professionalInformation != nil{
            dictionary["professionalInformation"] = professionalInformation.toDictionary()
        }
        
        dictionary["profileStatus"] = profileStatus
        
        dictionary["profileimage"] = profileimage
        
        dictionary["role"] = role
        
        dictionary["status"] = status
        
        dictionary["thumbprofileimage"] = thumbprofileimage
        
        dictionary["token"] = token
        
        dictionary["updatedDate"] = updatedDate
        
        dictionary["username"] = username
        
        dictionary["verificationCode"] = verificationCode
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdDate = aDecoder.decodeObject(forKey: "createdDate") as? String ?? ""
        createdDatetimestamp = aDecoder.decodeObject(forKey: "createdDatetimestamp") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        fillpassword = aDecoder.decodeObject(forKey: "fillpassword") as? String ?? ""
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String ?? ""
        forgotCode = aDecoder.decodeObject(forKey: "forgotCode") as? String ?? ""
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
        joined = aDecoder.decodeObject(forKey: "joined") as? String ?? ""
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String ?? ""
        password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
        phone = aDecoder.decodeObject(forKey: "phone") as? String ?? ""
        phoneCode = aDecoder.decodeObject(forKey: "phone_code") as? String ?? ""
        professionalInformation = aDecoder.decodeObject(forKey: "professionalInformation") as? ModelProfessionalInformation
        profileStatus = aDecoder.decodeObject(forKey: "profileStatus") as? String ?? ""
        profileimage = aDecoder.decodeObject(forKey: "profileimage") as? String ?? ""
        role = aDecoder.decodeObject(forKey: "role") as? String ?? ""
        status = aDecoder.decodeObject(forKey: "status") as? String ?? ""
        thumbprofileimage = aDecoder.decodeObject(forKey: "thumbprofileimage") as? String ?? ""
        token = aDecoder.decodeObject(forKey: "token") as? String ?? ""
        updatedDate = aDecoder.decodeObject(forKey: "updatedDate") as? String ?? ""
        username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        verificationCode = aDecoder.decodeObject(forKey: "verificationCode") as? String ?? ""
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        aCoder.encode(createdDate, forKey: "createdDate")
        
        aCoder.encode(createdDatetimestamp, forKey: "createdDatetimestamp")
        
        aCoder.encode(email, forKey: "email")
        
        aCoder.encode(fillpassword, forKey: "fillpassword")
        
        aCoder.encode(firstName, forKey: "firstName")
        
        aCoder.encode(forgotCode, forKey: "forgotCode")
        
        aCoder.encode(id, forKey: "id")
        
        aCoder.encode(image, forKey: "image")
        
        aCoder.encode(joined, forKey: "joined")
        
        aCoder.encode(lastName, forKey: "lastName")
        aCoder.encode(password, forKey: "password")
        
        aCoder.encode(phone, forKey: "phone")
        
        aCoder.encode(phoneCode, forKey: "phone_code")
        
        if professionalInformation != nil{
            aCoder.encode(professionalInformation, forKey: "professionalInformation")
        }
        
        aCoder.encode(profileStatus, forKey: "profileStatus")
        
        aCoder.encode(profileimage, forKey: "profileimage")
        
        aCoder.encode(role, forKey: "role")
        
        aCoder.encode(status, forKey: "status")
        
        aCoder.encode(thumbprofileimage, forKey: "thumbprofileimage")
        
        aCoder.encode(token, forKey: "token")
        
        aCoder.encode(updatedDate, forKey: "updatedDate")
        
        aCoder.encode(username, forKey: "username")
        
        aCoder.encode(verificationCode, forKey: "verificationCode")
        
    }
    
    //Save user object in UserDefault
    func saveCurrentUserInDefault() {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: UserDefaultsKey.kLoginUser)
        } catch {
            print("Not found")
        }
    }
    
    //Get user object from UserDefault
    class func getCurrentUserFromDefault() -> UserModel? {
        do {
            
            if let decoded  = UserDefaults.standard.data(forKey: UserDefaultsKey.kLoginUser),      let user = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? UserModel {
                return user
            }
        } catch {
            print("Couldn't read file.")
            return nil
        }
        return nil
    }
    
    //Remove user object from UserDefault
    class func removeUserFromDefault() {
        UserDefaults.standard.set(nil, forKey: UserDefaultsKey.kLoginUser)
    }
    
    // MARK: - API call
    class func userLogin(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kLogin, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let user = UserModel(dictionary: dataDict)
                user.saveCurrentUserInDefault()
                
                WebSocketChat.shared.isSocketConnected = false
                WebSocketChat.shared.connectSocket()
                
                withResponse(user, message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func checkforgotVerificationCode(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kcheckForgotCode, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func registerUser(withParam param: [String:Any], success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kRegisterUser, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let user = UserModel(dictionary: dataDict)
                UserDefaults.isUserLogin = true
                user.saveCurrentUserInDefault()
                
                withResponse(user, message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func verifyCode(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kverify, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let user = UserModel(dictionary: dataDict)
                UserDefaults.isUserLogin = true
                user.saveCurrentUserInDefault()
                
                WebSocketChat.shared.isSocketConnected = false
                WebSocketChat.shared.connectSocket()
                
                withResponse(user, message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func GetProfileUser(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kGetProfile, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any]{
                let user = UserModel(dictionary: dataDict)
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }
                
                user.saveCurrentUserInDefault()
                
                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }
                
                withResponse(user, message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func SaveProfileUser(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kUpdateUserProfile, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let user = UserModel(dictionary: dataDict)
                var token = ""
                if let u = UserModel.getCurrentUserFromDefault() {
                    token = u.token
                }
                
                user.saveCurrentUserInDefault()
                
                if let userdata = UserModel.getCurrentUserFromDefault(){
                    if userdata.token == "" {
                        userdata.token = token
                        userdata.saveCurrentUserInDefault()
                    }
                }
                
                withResponse(user, message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func uploadMedia(with param : [String:Any]?,image: UIImage?, success withResponse: @escaping (_ msg : String) -> Void, failure: @escaping FailureBlock) {
        
        SVProgressHUD.show()
        
        APIManager.makeMultipartFormDataRequest(AppConstant.API.kmediaUpload,image: image, imageName: kfiles, withParameter: param, withSuccess: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if isSuccess,let dataDict = dict[kData] as? [[String:Any]]{
                
                if let first = dataDict.first {
                    let msg = first[kmediaName] as? String ?? ""
                    withResponse(msg)
                } else {
                    failure(statuscode,message, .response)
                }
                
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func logoutUser(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.klogout, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue || statuscode == APIStatusCode.AuthTokenInvalied.rawValue) ? true : false
            if  isSuccess {
                self.removeUserFromDefault()
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func changePassword(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kChangePassword, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func forgotPassword(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kforgotPassword, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func resendVerificationCode(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kresendVerification, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func setAppFeedback(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksetAppFeedback, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    class func resetPassword(with param: [String:Any]?, success withResponse: @escaping (_ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.kresetPassword, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? ""
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess {
                withResponse(message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
    
    class func userSocialLogin(with param: [String:Any]?, success withResponse: @escaping (_ user: UserModel, _ strMessage : String) -> Void, failure: @escaping FailureBlock) {
        
        
        SVProgressHUD.show()
        APIManager.makeRequest(with: AppConstant.API.ksocialLogin, method: .post, parameter: param, success: {(response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            
            let message = dict[kMessage] as? String ?? ""
            let statuscode = dict[kstatus] as? String ?? "0"
            let isSuccess : Bool = (statuscode == APIStatusCode.success.rawValue ? true : false)
            if  isSuccess,let dataDict = dict[kData] as? [String:Any] {
                let user = UserModel(dictionary: dataDict)
                user.saveCurrentUserInDefault()
                
                WebSocketChat.shared.isSocketConnected = false
                WebSocketChat.shared.connectSocket()
                
                withResponse(user, message)
            }
            else {
                failure(statuscode,message, .response)
            }
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure("0",error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure("0",connectionError, .connection)
        })
    }
}
