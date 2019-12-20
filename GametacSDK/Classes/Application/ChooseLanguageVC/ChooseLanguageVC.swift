//
//  ChooseLanguageVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 9/30/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import PopupDialog

enum DisplayLanguage {
    case VN
    case CAM
}


class ChooseLanguageVC: UIViewController {
    
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnVietNam: UIButton!
    @IBOutlet weak var btnCampuchia: UIButton!
    @IBOutlet weak var lblVietNam: UILabel!
    @IBOutlet weak var lblCampuchia: UILabel!
    
    @IBAction func btnVietNam(_ sender: Any) {
        lblVietNam.font = UIFont(name: "OpenSans-Bold", size: 12)
        lblCampuchia.font = UIFont(name: "OpenSans", size: 12)
        self.languageChecked = "VietNam"
        print(languageChecked)
    }
    @IBAction func btnCampuchia(_ sender: Any) {
        lblCampuchia.font = UIFont(name: "OpenSans-Bold", size: 12)
        lblVietNam.font = UIFont(name: "OpenSans", size: 12)
        self.languageChecked = "Campuchia"
        print(languageChecked)
    }
    @IBAction func btnAccept(_ sender: Any) {
        
        if languageChecked == "" {
            self.showPopup(title: "Thông báo", msg: "Bạn chưa chọn ngôn ngữ")
        } else {
            let vc = ConfirmLanguageVC()
            vc.languageChecked = languageChecked
            self.navigationController?.pushViewController(vc, animated: false)
        }

        
    }
    
    var languageChecked: String = ""
    
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "OK", action: {
            //            self.dismiss(animated: true, completion: nil)
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


        
        self.btnAccept.layer.cornerRadius = 5
    }
}
