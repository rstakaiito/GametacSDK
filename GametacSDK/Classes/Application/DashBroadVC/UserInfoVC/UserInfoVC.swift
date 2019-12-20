//
//  UserInfoVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/1/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import PopupDialog

class UserInfoVC: UIViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblBirthday: UILabel!
    @IBOutlet weak var lblSex: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    
    @IBAction func btnChangeProfile(_ sender: Any) {
        debugPrint("Click Clak")
        let vc = ChangeProfileVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func configViewInfo(user:UserStruct){
        lblUserName.text = user.name
        lblBirthday.text = user.birthday
        switch user.gender {
        case 0:
            lblSex.text = "Nữ"
        case 1:
            lblSex.text = "Nam"
        default:
            lblSex.text = "Chưa xác định"
        }
        
        lblPhoneNumber.text = user.phone
        lblEmail.text = user.email
        lblFullName.text = user.fullName
        lblID.text = user.id.description
        
        lblLanguage.text = "Tiếng Việt"
        
    }
    
    
    var userInfo: UserStruct?
    
    func getUserInfo(){
        UserServices.sharedInstance.getUserInfo { (msg, userInfo) in
            switch msg.code{
            case 200:
                self.configViewInfo(user: userInfo)
            case 800:
                UserServices.sharedInstance.refreshToken(completion: { (msg, userInfo) in
                    switch msg.code {
                    case 200:
                        debugPrint("Refresh token success")
                        //appDelegate().infoLogined = userInfo
                        NSAuthentication.sharedInstance.profile = userInfo
                        self.getUserInfo()
                    default:
                        debugPrint("Refresh token failed")
                        self.reLogin()
                    }
                })
            default:
                self.showPopup(title: "Thông báo", msg: msg.message)
            }
        }
    }
    
    
    
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "Đóng", action: {
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getUserInfo()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchProfile), name: NSNotification.Name(rawValue: "reloadGlobalUserProfile"), object: nil)
    }
    
    @objc func fetchProfile(){
        let profile = NSAuthentication.sharedInstance.profile
        self.lblUserName.text = profile.name
        self.lblUserName.text = profile.name
        self.lblBirthday.text = profile.birthday
        self.lblPhoneNumber.text = profile.phone
        self.lblEmail.text = profile.email
        self.lblFullName.text = profile.fullName
    }
}
