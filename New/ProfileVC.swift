//
//  ProfileVC.swift
//  LTAP
//
//  Created by APPLE on 27/04/21.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet var tblView: UITableView!
    @IBOutlet var tblViewHeight: NSLayoutConstraint!
    @IBOutlet var imgUserProfile: UIImageView!
    @IBOutlet var lblFirstName: UILabel!
    @IBOutlet var lblLastname: UILabel!
    @IBOutlet var lblJoinDate: UILabel!
    
    private let arrProfileOption : [ProfileOption] = [.Profile,.EquipmentLoanProgram,.SharedFiles]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
        self.addTableViewOberver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeTableViewObserver()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
        }
    }

    @IBAction func btnSignOut(_ sender: Any) {
        let alt = UIAlertController(title: AppConstant.AlertMessages.kLogout, message: nil, preferredStyle: .alert)
        alt.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            self.logout()
        }))
        alt.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alt, animated: true, completion: nil)
    }
    
    @IBAction func btnSetting(_ sender: Any) {
        self.appNavigationController?.push(ChangePasswordVC.self)
    }
    
}
//MARK- UI Helper
extension ProfileVC {
    
    private func initConfig(){
        self.tblView.register(ProfileOptionTCell.self)
        self.tblView.delegate = self
        self.tblView.dataSource = self
        if let user = UserModel.getCurrentUserFromDefault() {
            self.imgUserProfile.setImage(withUrl: user.profileimage)
            self.lblFirstName.text = user.firstName
            self.lblLastname.text = user.lastName
            self.lblJoinDate.text = user.joined
        }
    }
    
    private func configureNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        appNavigationController?.setNavigationBarHidden(false, animated: true)
        appNavigationController?.navigationBar.backgroundColor = UIColor.white
        appNavigationController?.appNavigationControllersetTitleWithBack(isDarkMode: false, title: "Profile", navigationItem: self.navigationItem)
        appNavigationController?.btnNextClickBlock = {
            self.appNavigationController?.push(VerificationCodeInputVC.self)
        }
        self.title = "Profile"
        appNavigationController?.navigationBar.configure(barTintColor: UIColor.white, tintColor: UIColor.CustomColor.barbuttoncolor)
    }
}

//MARK:- UIBUtton Action
extension ProfileVC {
    
    @IBAction func btnFaq(_ sender: Any) {
        self.appNavigationController?.push(FaqListVC.self)
    }
    
    @IBAction func btnAboutKansasLTAP(_ sender: Any) {
        self.appNavigationController?.push(AboutUsVC.self)
    }
    
    
}

//MARK:- UITableview Delegate
extension ProfileVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrProfileOption.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, with: ProfileOptionTCell.self)
        
        cell.setData(obj: self.arrProfileOption[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.arrProfileOption[indexPath.row]
        if  obj == .Profile {
            self.appNavigationController?.push(UpdateProfileVC.self)
        }
        else if obj == .EquipmentLoanProgram {
            self.appNavigationController?.push(EquipmentLoanListVC.self)
        }
        else if obj == .MouseTrapApplications {
            self.appNavigationController?.push(BuildBetterMouseTrapApplictionListVC.self)
        }
    }
}

//MARK: - Tableview Observer
extension ProfileVC {
    
    private func addTableViewOberver() {
        self.tblView.addObserver(self, forKeyPath: ObserverName.kcontentSize, options: .new, context: nil)
    }
    
    func removeTableViewObserver() {
        if self.tblView.observationInfo != nil {
            self.tblView.removeObserver(self, forKeyPath: ObserverName.kcontentSize)
        }
    }
    
    /**
     This method is used to observeValue in table view.
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if let obj = object as? UITableView {
            if obj == self.tblView && keyPath == ObserverName.kcontentSize {
                self.tblViewHeight.constant = self.tblView.contentSize.height
                self.tblView.layoutIfNeeded()
            }
        }
    }
}

//MARK:- API Calling
extension ProfileVC {
    
    func logout() {
        self.view.endEditing(true)
        if let user = UserModel.getCurrentUserFromDefault() {
            let dict : [String:Any] = [
                klangType : LTAP.sharedInstance.languageType,
                ktoken : user.token,
            ]
            let param : [String:Any] = [
                kData : dict
            ]
            UserModel.logoutUser(with: param) { (msg) in
                self.showMessage(msg, themeStyle: .success)
                appDelegate.clearUserDataForLogout()
                self.appNavigationController?.showLoginController()
            } failure: {[unowned self] (statuscode,error, errorType) in
                print(error)
                
                if statuscode == APIStatusCode.NoRecord.rawValue {
                    
                } else {
                    if !error.isEmpty {
                        self.showMessage(errorType.rawValue, themeStyle: .error)
                    }
                }
            }
        }
    }
    
}
// MARK: - ViewControllerDescribable
extension ProfileVC: ViewControllerDescribable {
    static var storyboardName: StoryboardNameDescribable {
        return UIStoryboard.Name.Profile
    }
}

// MARK: - AppNavigationControllerInteractable
extension ProfileVC: AppNavigationControllerInteractable { }
