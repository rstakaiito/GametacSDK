//
//  LoginSuccessVC.swift
//  AppsFlyer
//
//  Created by Kien Nguyen Duc on 12/2/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit

class LoginSuccessVC: UIViewController {

    @IBAction func btnShowInfo(_ sender: Any) {
        //slideMenuController()?.openLeft()
    }
    @IBAction func btnLogout(_ sender: Any) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "Thoát tài khoản?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Thoát", style: .destructive , handler:{ (UIAlertAction)in
                let vc = LoginVC()
                UserDefaults.standard.setValue(nil, forKey: "access_token")
                UserDefaults.standard.setValue(nil, forKey: "refresh_token")

                let navigationController = UINavigationController(rootViewController: vc)
                //appDelegate().window?.rootViewController = navigationController
                self.navigationController?.popToRootViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Hủy", style: .cancel, handler:{ (UIAlertAction)in
            }))
            self.present(alert, animated: true, completion: {
            })
            
        }
    }
    
    @IBAction func btnPurchase(_ sender: Any) {
        let vc = InAppPurchaseVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
    }




}
