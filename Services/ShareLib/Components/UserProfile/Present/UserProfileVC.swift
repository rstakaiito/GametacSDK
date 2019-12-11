//
//  UserProfileVC.swift
//  MobiHair Customer
//
//  Created by Duong Viet Cuong on 10/24/17.
//  Copyright © 2017 newsoft. All rights reserved.
//

import UIKit
import Kingfisher

struct UserProfileMenuItem{
    var img:UIImage
    var content:String
    var code:Int
}

struct UserProfileMenu{
    var content:String
    var items:[UserProfileMenuItem]
}

class UserProfileVC: UIViewController {

    let arrUIMenu = [
        UserProfileMenu(content: "TÀI KHOẢN", items: [
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_password"), content: "Đổi mật khẩu", code: 1001),
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_info"), content: "Thay đổi thông tin cá nhân", code: 1002)
            ]),
        UserProfileMenu(content: "GIỚI THIỆU", items: [
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_infoapp"), content: "Thông tin ứng dụng", code: 2001),
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_fanpage"), content: "Fanpage facebook",   code: 2002),
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_apprate"), content: "Đánh giá ứng dụng",  code: 2003),
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_feedback"), content: "Góp ý và phản hồi",  code: 2004),
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_email"), content: "Email",   code: 2005)
            ]),
        UserProfileMenu(content: "ĐĂNG XUẤT", items: [
            UserProfileMenuItem(img: #imageLiteral(resourceName: "profile_password"), content: "Thoát tài khoản", code: 3001)
            ]),
    ]
    
    @IBOutlet weak var tblMenu:UITableView!
    @IBOutlet weak var lblUserTitle:UILabel!
    @IBOutlet weak var lblUserSubtitle:UILabel!
    @IBOutlet weak var imgUserAvatar:UIImageView!
    
    @objc func displayData(){
        let profile = NSAuthentication.sharedInstance.profile
        lblUserTitle.text = profile.name
        lblUserSubtitle.text = "@\(profile.phone)"
        print("X")
        print(profile.avatar)
       imgUserAvatar.loadImage(url: profile.avatar)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblMenu.rowHeight = UITableView.automaticDimension
        tblMenu.reloadData()
        
        displayData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayData), name: NSNotification.Name(rawValue: "reloadGlobalUserProfile"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func selectMenu(code:Int){
//        switch code {
//        case 1001:
//            // Goto change password screen
//            let changePasswordVC = ChangePasswordVC(nibName: "ChangePasswordVC", bundle: nil)
//            self.present(changePasswordVC, animated: true, completion: nil)
//            break
//        case 1002:
//            let changeProfileVC = ChangeProfileVC(nibName:"ChangeProfileVC",bundle:nil)
//            self.present(changeProfileVC, animated: true, completion: nil)
//            break
//        case 2001:
//            // App information
//            UIApplication.shared.openURL(URL(string: "http://mobilehair.vn")!)
//            break
//        case 2002:
//            // Fanpage facebook
//            UIApplication.shared.openURL(URL(string: "https://www.facebook.com/Mobilehair.vn/")!)
//            break
//        case 2003:
//            UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/app/id10")!)
//            break
//        case 2004:
//            // Feedback
//            UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/app/id10")!)
//            break
//        case 2005:
//            // Feedback
//            let email = "info@mobilehair.vn"
//            UIApplication.shared.openURL(URL(string: "mailto:\(email)")!)
//            break
//        case 3001:
//            // Logout
//            self.doLogout()
//            break
//        default:
//            break
//        }
//    }


    
    // Do Logout
    func doLogout(){
        NSAuthentication.sharedInstance.logout()

        
    }
}


extension UserProfileVC:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrUIMenu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUIMenu[section].items.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView.init(reuseIdentifier: "Header")
        header.textLabel?.text = arrUIMenu[section].content
        header.textLabel?.textColor = UIColor.gray
        header.textLabel?.font = UIFont.systemFont(ofSize: 10)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .center
        header.backgroundView = UIView(frame: header.bounds)
        header.backgroundView?.backgroundColor = UIColor.white
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        let data = arrUIMenu[indexPath.section].items[indexPath.row]
        cell.imageView?.image = data.img
        cell.textLabel?.text =  data.content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

//extension UserProfileVC:UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let code = self.arrUIMenu[indexPath.section].items[indexPath.row].code
//        self.selectMenu(code: code)
//    }
//}





