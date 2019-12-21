//
//  ChangeProfileVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/1/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import PopupDialog

enum DisplaySex {
    case Male
    case Female
}

class ChangeProfileVC: UIViewController {
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfReNewPassword: UITextField!
    @IBOutlet weak var tfBirthDay: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var scrMain: UIScrollView!
    @IBAction func tfBirthDay(_ sender: Any) {
        createDatePicker()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnMale(_ sender: Any) {
//        btnMale.setImage(#imageLiteral(resourceName: "Ellipse 1"), for: .normal)
        switch typeSex {
        case .Male:
            print("Không làm gì")
        case .Female:
            btnMale.setImage(#imageLiteral(resourceName: "Ellipse 1"), for: .normal)
            btnFemale.setImage(UIImage(named: "Rectangle 30"), for: .normal)
            
            typeSex = .Male
            self.sex = 1
            print("\(sex) là nam")
            break
        }
    }
    @IBAction func btnFemale(_ sender: Any) {
        switch typeSex {
        case .Male:
            
            btnFemale.setImage(#imageLiteral(resourceName: "Ellipse 1"), for: .normal)
            btnMale.setImage(UIImage(named: "Rectangle 30"), for: .normal)
            typeSex = .Female
            self.sex = 0
            print("\(sex) là nữ")
            break
        case .Female:
            print("Không làm gì")
        }
    }
    @IBAction func btnUpdate(_ sender: Any) {
        updateInfo()
    }
    
    
    var typeSex: DisplaySex = .Male
    var sex: Int = 1
    var DatePickerView: UIDatePicker = UIDatePicker()
    var dateBirth: String = ""
    
    
    func updateInfo(){
        UserServices.sharedInstance.changeInfomation(fullName: tfFullName.text!,
                                                     birthday: tfBirthDay.text!,
                                                     gender: sex,
                                                     phone: tfPhoneNumber.text!,
                                                     new_password: tfNewPassword.text!,
                                                     new_password_confirmation: tfReNewPassword.text!,
                                                     password: tfOldPassword.text!) { (msg, user) in
                                                        switch msg.code {
                                                        case 200:
                                                            NSAuthentication.sharedInstance.profile = user
                                                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadGlobalUserProfile"), object: nil)
                                                          self.showPopup(title: "Thông báo", msg: msg.message)

                                                            
                                                            
                                                            
                                                        default:
                                                            self.showPopup(title: "Thông báo", msg: msg.message)
                                                        }
        }
    }
    
    
    func createDatePicker(){
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.locale = Locale(identifier: "en")
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        tfBirthDay.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
    }

   @objc func datePickerValueChanged(sender:UIDatePicker) {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "vi_VN")
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatter.dateStyle = DateFormatter.Style.short
    tfBirthDay.text = dateFormatter.string(from: sender.date)
    self.dateBirth = dateFormatter.string(from: sender.date)
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
        guard let userInfo = notification.userInfo ,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height + 45, right: 0)
        scrMain.contentInset = contentInset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        addObservers()
    }
    
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "Đóng", action: {
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(popup, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboard()
    }
}
