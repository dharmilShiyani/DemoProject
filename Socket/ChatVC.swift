//
//  ChatVC.swift
//  Infallible Care
//
//  Created by APPLE on 11/05/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit
import ChameleonFramework
import Starscream

class ChatVC: UIViewController {
    
    var arrChatList = [ModelChatList]()
    var userRole = String()
    
    @IBOutlet var tblView: UITableView!
    @IBOutlet var btnUsers: UIButton!
    @IBOutlet var btnCaregivers: UIButton!
    @IBOutlet var OptionBgView: UIView!
    @IBOutlet var txtSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- UITableview Register Method
        self.txtSearch.delegate = self
        tblView.registerCell(withNib: "ChatListCell")
        tblView.delegate = self
        tblView.dataSource = self
        if kAppDelegate.userRole == "3" {
            OptionBgView.gone(axis: .vertical, spaces: [.top,.bottom], completion: nil)
        }
        btnCaregivers.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.btnCaregivers.frame, colors: [#colorLiteral(red: 0.3333333333, green: 0.8156862745, blue: 0.8980392157, alpha: 1),#colorLiteral(red: 0.168627451, green: 0.5960784314, blue: 0.7294117647, alpha: 1)])
        btnUsers.backgroundColor = .clear
        btnCaregivers.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnUsers.setTitleColor(#colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.6666666667, alpha: 1), for: .normal)
        self.userRole = "3"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        kAppDelegate.Socket.delegate = self
        getData()
        NotificationCenter.default.addObserver(self, selector: #selector(socketconnected(notfication:)), name: NSNotification.Name(rawValue: kSocketConnect), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: kSocketConnect), object: nil)
    }
    
    //MARK:- Notification
    @objc func socketconnected(notfication: NSNotification) {
        kAppDelegate.Socket.delegate = self
    }
    
    func getData() {
        if kAppDelegate.isScoketConnect {showLoaderHUD(strMessage: "")
            let dictionary = ["hookMethod": kChatinbox,
                              "user_role" : self.userRole,
                              "search" : self.txtSearch.text ?? ""] as [String : Any]
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: dictionary,
                options: []) {
                let theJSONText = String(data: theJSONData,
                                         encoding: .utf8)
                print("JSON string = \(theJSONText!)")
                kAppDelegate.Socket.write(string: "\(theJSONText!)")
            }
        }else{
            kAppDelegate.connectSocket()
        }
    }
    @IBAction func btnMenu(_ sender: Any) {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func btnCaregivers(_ sender: Any) {
        btnCaregivers.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.btnCaregivers.frame, colors: [#colorLiteral(red: 0.3333333333, green: 0.8156862745, blue: 0.8980392157, alpha: 1),#colorLiteral(red: 0.168627451, green: 0.5960784314, blue: 0.7294117647, alpha: 1)])
        btnUsers.backgroundColor = .clear
        btnCaregivers.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        btnUsers.setTitleColor(#colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.6666666667, alpha: 1), for: .normal)
        self.userRole = "3"
        getData()
    }
    
    @IBAction func btnUser(_ sender: Any) {
        btnUsers.backgroundColor = GradientColor(gradientStyle: .topToBottom, frame: self.btnUsers.frame, colors: [#colorLiteral(red: 0.3333333333, green: 0.8156862745, blue: 0.8980392157, alpha: 1),#colorLiteral(red: 0.168627451, green: 0.5960784314, blue: 0.7294117647, alpha: 1)])
        btnCaregivers.backgroundColor = .clear
        btnCaregivers.setTitleColor(#colorLiteral(red: 0.5764705882, green: 0.5764705882, blue: 0.6666666667, alpha: 1), for: .normal)
        btnUsers.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.userRole = "2"
        getData()
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idNotificationVC) as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- UITextFeild Delegate
extension ChatVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.getData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtSearch.resignFirstResponder()
        return true
    }
}
//MARK:- UITableview Delegate Method
extension ChatVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.arrChatList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        cell.imgUserProfile.setImageFromURL(self.arrChatList[indexPath.row].thumbImage)
        cell.lblUserName.text = self.arrChatList[indexPath.row].name
        cell.lblMessage.text = self.arrChatList[indexPath.row].message.decode()
        cell.lblTime.text = self.arrChatList[indexPath.row].formatedDate
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idChatDetailVC) as! ChatDetailVC
        vc.ChatId = self.arrChatList[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- WebSocket Delegate Method
extension ChatVC : WebSocketDelegate {
    
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
        switch event {
        case .connected(let headers):
            // isConnected = true
            print("websocket is connected: \(headers)")
            let token = ModelUserData.getUserDataFromUserDefaults().token
            
            if token == "" {
                
            }
            else {
                kAppDelegate.isScoketConnect = true
                let dictionary = ["token": ModelUserData.getUserDataFromUserDefaults().token,
                                  "hookMethod": "registration"]
                if let theJSONData = try? JSONSerialization.data(
                    withJSONObject: dictionary,
                    options: []) {
                    let theJSONText = String(data: theJSONData,
                                             encoding: .utf8)
                    print("JSON string = \(theJSONText!)")
                    kAppDelegate.Socket.write(string: "\(theJSONText!)")
                    
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
            hideLoaderHUD()
            let dict = string.toJSON() as? [String:AnyObject]

            let method = dict?["hookMethod"] as? String ?? ""
            
            if method == kChatinbox {
                self.arrChatList.removeAll()
                if let data = dict?["data"] as? [[String:Any]] {
                    for item in data {
                        self.arrChatList.append(ModelChatList.init(fromDictionary: item))
                    }
                    self.tblView.reloadData()
                }
                if self.arrChatList.count == 0 {
                    self.tblView.EmptyMessage(message: "We couldn't find anyone to show for '\(self.txtSearch.text ?? "")'")
                }
                else{
                    self.tblView.EmptyMessage(message: "")
                }
            }
            
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
            kAppDelegate.connectSocket()
            print("Not Conected")
            kAppDelegate.isScoketConnect = false
            break
        case .error(let error):
            kAppDelegate.connectSocket()
            print("Not Conected, error: \(String(describing: error))")
            kAppDelegate.isScoketConnect = false
            break
        }
    }
}
