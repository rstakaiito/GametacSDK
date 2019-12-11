//
//  SwitchAccountVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/10/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit

class SwitchAccountVC: UIViewController {
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDismiss: UIButton!
    
    @IBAction func btnUpdate(_ sender: Any) {
    }
    @IBAction func btnDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func switchAccount(){
//        UserServices.sharedInstance.SwitchToActiveAccount(name: tfUserName.text!, email: tfEmail.text!, password: tfPassword.text!, password_confirmation: tfRePassword.text!) { (msg, newInfo) in
//            switch msg.code{
//            case 200:
//
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tfUserName.addShadowTextField()
        self.tfPassword.addShadowTextField()
        self.tfRePassword.addShadowTextField()
        self.tfEmail.addShadowTextField()
        self.btnUpdate.addShadowTextField()
        self.btnDismiss.addShadowTextField()
        
    }
}
