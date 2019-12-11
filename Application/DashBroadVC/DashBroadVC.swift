//
//  DashBroadVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 9/30/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

//protocol LeftMenuProtocol : class {
//    func changeViewController(_ menu: LeftMenu)
//}

class DashBroadVC: UIViewController {
    
    @IBAction func btnClose(_ sender: Any) {
        slideMenuController()?.closeLeft()
    }
    @IBAction func btnUserInfo(_ sender: Any) {
        btnUserInfo.setImage(#imageLiteral(resourceName: "ic_user"), for: .normal)
        btnReport.setImage(#imageLiteral(resourceName: "ic_report_fill_new"), for: .normal)
        btnNotification.setImage(#imageLiteral(resourceName: "ic_noti_fill_new"), for: .normal)
        configViewUserInfo()
    }
    
    @IBAction func btnNotification(_ sender: Any) {
        btnUserInfo.setImage(#imageLiteral(resourceName: "ic_user_fill"), for: .normal)
        btnReport.setImage(#imageLiteral(resourceName: "ic_report_fill_new"), for: .normal)
        btnNotification.setImage(#imageLiteral(resourceName: "ic_noti"), for: .normal)
        configViewNotification()
    }
    @IBAction func btnReport(_ sender: Any) {
        btnUserInfo.setImage(#imageLiteral(resourceName: "ic_user_fill"), for: .normal)
        btnReport.setImage(#imageLiteral(resourceName: "ic_report"), for: .normal)
        btnNotification.setImage(#imageLiteral(resourceName: "ic_noti_fill_new"), for: .normal)
        configViewReport()
    }
    
    
    @IBOutlet weak var btnReport: UIButton!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnUserInfo: UIButton!
    @IBOutlet weak var controlView: UIView!
    

    
    func configViewNotification(){
        let vc = NotifVC()
        let navController:UINavigationController = UINavigationController.init(rootViewController: vc)
        addChild(navController)
        self.controlView.addSubview(navController.view)
        navController.isNavigationBarHidden = true
        navController.view.frame = controlView.bounds
        navController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navController.view.frame = CGRect(0, 0, controlView.frame.width, controlView.frame.height)
        navController.didMove(toParent: self)
    }
    
    func configViewReport(){

        let vc = ReportVC()
        let navController:UINavigationController = UINavigationController.init(rootViewController: vc)
        addChild(navController)
        self.controlView.addSubview(navController.view)
        navController.isNavigationBarHidden = true
        navController.view.frame = controlView.bounds
        navController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navController.view.frame = CGRect(0, 0, controlView.frame.width, controlView.frame.height)
        navController.didMove(toParent: self)
    }
    
    func configViewUserInfo(){
        let vc = UserInfoVC()

        let navController:UINavigationController = UINavigationController.init(rootViewController: vc)
        addChild(navController)
        self.controlView.addSubview(navController.view)
        navController.isNavigationBarHidden = true
        navController.view.frame = controlView.bounds
        navController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navController.view.frame = CGRect(0, 0, controlView.frame.width, controlView.frame.height)
        navController.didMove(toParent: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(controlView.frame)
        configViewUserInfo()
    }

}
