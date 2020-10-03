//
//  HomeVC.swift
//  Infallible Care
//
//  Created by APPLE on 07/05/20.
//  Copyright © 2020 APPLE. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var pageNumberCount = 1
    var isCallNewPage = true
    var arrNearbyCareGiver = [ModelCareGiver]()
    
    
    @IBOutlet var tblCaregiver: UITableView!
    @IBOutlet var tblCareGiverHeight: NSLayoutConstraint!
    @IBOutlet var txtSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tblCaregiver.registerCell(withNib: "CareGiverNearByCell")
        self.tblCaregiver.delegate = self
        self.tblCaregiver.dataSource = self
        self.tblCaregiver.reloadData()
        txtSearch.delegate = self
        
        /*var url = NSURL(string: "https://intro-app.com/app-link/123abghshj")

        if url != nil {
            let task = URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) -> Void in
                print(data)

                if error == nil {

                    var urlContent = NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as NSString?
                    
                    let josnString = (urlContent as? String)?.slice(from: "meta property=\"deepData\" content=", to: "/>")
                    let data = josnString as? String
                    print(urlContent)
                    print(josnString)
                    let finalDat = data?.replacingOccurrences(of: "\\", with: "")
                    let finalDat2 = finalDat?.replacingOccurrences(of: "\\", with: "")
                    let finalDat3 = finalDat2?.replacingOccurrences(of: "\"\\\"", with: "")

                    print(finalDat2)
                }
            })
            task.resume()
        }*/
        self.callCaregiverlistAPI(page: pageNumberCount)
    }

    override func viewWillAppear(_ animated: Bool) {
        setAfter { 
            self.tblCareGiverHeight.constant = CGFloat(94*self.tblCaregiver.numberOfRows(inSection: 0))
        }
        if !kAppDelegate.isMessageShow {
            kAppDelegate.isMessageShow = true
            let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idFounderMsgVC) as! FounderMsgVC
//            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func btnMenu(_ sender: Any) {
        sideMenuController?.showLeftViewAnimated()
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        let vc = loadVC(strStoryboardId: SB_MAIN, strVCId: idNotificationVC) as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCreateJob(_ sender: Any) {
        let vc = loadVC(strStoryboardId: SB_PostJob, strVCId: idPostJob1VC) as! PostJob1VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//MARK:- UITextFeild Delegate
extension HomeVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.arrNearbyCareGiver.removeAll()
        self.tblCaregiver.reloadData()
        self.isCallNewPage = true
        self.pageNumberCount = 1
        self.callCaregiverlistAPI(page: pageNumberCount)
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.arrNearbyCareGiver.removeAll()
        self.tblCaregiver.reloadData()
        self.isCallNewPage = true
        self.pageNumberCount = 1
        self.callCaregiverlistAPI(page: pageNumberCount)
    }
}

//MARK:- UITableview Delegate Method
extension HomeVC : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNearbyCareGiver.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CareGiverNearByCell", for: indexPath) as! CareGiverNearByCell
        cell.imgProfile.setImageFromURL(self.arrNearbyCareGiver[indexPath.row].thumbprofileimage)
        cell.lblName.text = self.arrNearbyCareGiver[indexPath.row].firstName + self.arrNearbyCareGiver[indexPath.row].lastName
        cell.RatingView.rating = Double(self.arrNearbyCareGiver[indexPath.row].avgRating) ?? 0.0
        cell.lblRating.text = self.arrNearbyCareGiver[indexPath.row].totalRating
        cell.RatingView.settings.updateOnTouch = false
        let skills = self.arrNearbyCareGiver[indexPath.row].skills.compactMap{ $0.name}
        cell.lblWork.text = skills.joined(separator: ", ")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let vc =  loadVC(strStoryboardId: SB_MAIN, strVCId: idCareGiverProfile) as! CareGiverProfile
        vc.modelCareGiver = self.arrNearbyCareGiver[indexPath.row]
        vc.strCareGiverID = self.arrNearbyCareGiver[indexPath.row].id

         self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let needToFetchNewData = indexPath.row == arrNearbyCareGiver.count
        if needToFetchNewData  && isCallNewPage{
            self.callCaregiverlistAPI(page: pageNumberCount)
        }
    }
}

//MARK:- API Calling
extension HomeVC {
    
    func callCaregiverlistAPI(page:Int) {
        self.view.endEditing(true)
        let param:NSMutableDictionary = ["langType" : kLengType,
                                         "page" : "\(page)",
                                         "limit": "10",
                                         "token": ModelUserData.getUserDataFromUserDefaults().token ?? "",
                                         "search" : self.txtSearch.text ?? ""]
        
        let data:NSMutableDictionary = ["data":param]
        
        HttpRequestManager.sharedInstance.requestWithPostJsonParam(service: kCaregiverlist_URL, parameters: data, showLoader: true) { (response, error) in
            if error != nil
            {
                showMessageWithRetry(RetryMessage,3, buttonTapHandler: { _ in
                    hideBanner()
                    self.callCaregiverlistAPI(page: page)
                })
                return
            }
            else {
                
                if response?.value(forKey: kStatus) as? String ?? "" == kStatusSuccess {
                    self.isCallNewPage = true
                    self.pageNumberCount += 1
                    let arrData = response?.value(forKey: "data") as? NSMutableArray
                    
                    for item in arrData! {
                        let data:NSMutableDictionary = item as! NSMutableDictionary
                        
                        let model : ModelCareGiver = ModelCareGiver.init(fromDictionary: data as! [String : Any])
                        self.arrNearbyCareGiver.append(model)
                        
                    }
                    DispatchQueue.main.async {
                        self.tblCaregiver.reloadData()
                        self.tblCareGiverHeight.constant = CGFloat(94*self.tblCaregiver.numberOfRows(inSection: 0))
                    }
                }
                else if response?.value(forKey: kStatus) as? String ?? "" == kStatusNoRecord {
                    self.isCallNewPage = false
                    self.pageNumberCount += 1
                    self.tblCaregiver.reloadData()
                }
                else {
                    //self.showToastMessage(message: response?.value(forKey: kMessage) as? String ?? "")
                }
                
                if self.arrNearbyCareGiver.count == 0 {
                    self.tblCaregiver.EmptyMessage(message: response?.value(forKey: kMessage) as? String ?? "")
                }
                else {
                    self.tblCaregiver.EmptyMessage(message: "")
                }
            }
        }
    }
}
class AnimationUtility: UIViewController, CAAnimationDelegate {

    static let kSlideAnimationDuration: CFTimeInterval = 0.4

    static func viewSlideInFromRight(toLeft views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromRight
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromLeft(toRight views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromLeft
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromTop(toBottom views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromBottom
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }

    static func viewSlideInFromBottom(toTop views: UIView) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = kSlideAnimationDuration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = CATransitionSubtype.fromTop
//        transition?.delegate = (self as! CAAnimationDelegate)
        views.layer.add(transition!, forKey: nil)
    }
}
extension String {

    func slice(from: String, to: String) -> String? {

        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
