//
//  RegistryVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 9/30/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import PopupDialog

class RegistryVC: UIViewController {
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var bntRegistry: UIButton!
    @IBOutlet weak var scrMain: UIScrollView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnRegistry(_ sender: Any) {
        registry()
    }
    
    var client_id = 5
    var client_secret = "hUkYHxRk4wtS8gIQBePHuvPX3IfrgkOvw3Z8M1NH"
    
    
    
    public var didRegistryDialogComplete:()->() = {}
    
    
    
    
    
    func registry(){
        UserServices.sharedInstance.registry(name: tfUserName.text!,
                                             email: tfEmail.text!,
                                             password: tfPassword.text!,
                                             password_confirmation: tfRePassword.text!,
                                             fullName: tfFullName.text!,
                                             client_id: client_id,
                                             client_secret: client_secret) { (msg) in
                                                print(msg)
                                                if !msg.error{
                                                    print(msg)
                                                    self.showPopup(title: "Thông báo", msg: msg.message)
                                                } else {
                                                    print(msg)
                                                    self.showPopup(title: "Thông báo", msg: msg.message)
                                                }
        }
    }
    
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "Đóng", action: {
            self.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true) {
                self.didRegistryDialogComplete()
            }
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    func configElementsView(){
        self.bntRegistry.layer.cornerRadius = 5
        self.tfUserName.addShadowTextField()
        self.tfPassword.addShadowTextField()
        self.tfEmail.addShadowTextField()
        self.tfRePassword.addShadowTextField()
        self.tfFullName.addShadowTextField()
        self.tfUserName.layer.borderWidth = 1
        self.tfUserName.layer.cornerRadius = 5
        self.tfUserName.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfPassword.layer.borderWidth = 1
        self.tfPassword.layer.cornerRadius = 5
        self.tfPassword.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfEmail.layer.borderWidth = 1
        self.tfEmail.layer.cornerRadius = 5
        self.tfEmail.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfRePassword.layer.borderWidth = 1
        self.tfRePassword.layer.cornerRadius = 5
        self.tfRePassword.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfFullName.layer.borderWidth = 1
        self.tfFullName.layer.cornerRadius = 5
        self.tfFullName.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfUserName.delegate = self
        self.tfPassword.delegate = self
        self.tfRePassword.delegate = self
        self.tfEmail.delegate = self
        self.tfFullName.delegate = self
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        scrMain.contentInset = UIEdgeInsets.zero
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
               let keyboardRectangle = keyboardFrame.cgRectValue
               let keyboardHeight = keyboardRectangle.height
            
            let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 40, right: 0)
            scrMain.contentInset = contentInset
            
           }
         
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        addObservers()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
        self.configElementsView()
    }
}
extension RegistryVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        tfUserName.becomeFirstResponder()
        if textField == tfUserName {
            tfEmail.becomeFirstResponder()
        } else if textField == tfEmail {
            tfPassword.becomeFirstResponder()
        } else if textField == tfPassword {
            tfRePassword.becomeFirstResponder()
        } else if textField == tfRePassword {
            tfFullName.becomeFirstResponder()
        } else if textField == tfFullName {
            performAction()
        }
        
        self.dismiss(animated: true, completion: nil)
        return true
    }
    
    func performAction() {
        // Do something here
        registry()
    }
}
