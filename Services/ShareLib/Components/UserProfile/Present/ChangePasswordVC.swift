//
//  ChangePasswordVC.swift
//  MobiHair Customer
//
//  Created by Duong Viet Cuong on 10/25/17.
//  Copyright © 2017 newsoft. All rights reserved.
//

import UIKit
import PopupDialog

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txtOldPassword:UITextField!
    @IBOutlet weak var txtNewPassword:UITextField!
    @IBOutlet weak var txtReNewPassword:UITextField!
    @IBOutlet weak var btnSubmitData:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        
        self.txtOldPassword.addShadow()
        self.txtNewPassword.addShadow()
        self.txtReNewPassword.addShadow()
        self.btnSubmitData.addShadow()
    }
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "OK", action: {
            //            self.dismiss(animated: true, completion: nil)
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    
    @IBAction func btnChangeClicked(){
        if(txtReNewPassword.text != txtNewPassword.text){
            // Error
            self.showPopup(title: "Thông báo", msg: "Mật khẩu nhập lại 2 lần chưa giống nhau")
            return
        }
//        changePassword()

    }
    
    @IBAction func btnCancelClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
//    func changePassword(){
//        view.endEditing(true)
//        self.showActivityIndicator(type: .ballRotateChase, color: #colorLiteral(red: 0.06482834369, green: 0.5165621042, blue: 0.7741937041, alpha: 1))
//        UserService.sharedInstance.changePassword(oldPassword: txtOldPassword.text!,newPassword: txtNewPassword.text!) { (error) in
//            self.hideActivityIndicator()
//            if !(error.error){
//                let popup = PopupDialog.init(title: "Thông báo", message: "Bạn đã thay đổi mật khẩu hoàn tất")
//                popup.addButton(CancelButton(title: "Đóng") {
//                    self.dismiss(animated: true, completion: nil)
//                })
//                self.present(popup, animated: true, completion: nil)
//                return
//            }
//            self.showPopup(title: "Thông báo", msg: error.msg)
//        }
//    }
}
