//
//  ConfirmLanguageVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 10/9/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit

class ConfirmLanguageVC: UIViewController {

    @IBOutlet weak var lblConfirm: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var imgCountry: UIImageView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    @IBAction func btnConfirm(_ sender: Any) {
        let vc = LoginVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configHeadernameFontSize(){
        let fontSizeLabel1: CGFloat = (UIScreen.main.bounds.width * 20) / 812
        lblConfirm.font = lblConfirm.font.withSize(fontSizeLabel1)
        
        let fontSizeLabel2: CGFloat = (UIScreen.main.bounds.width * 12) / 812
        lblLanguage.font = lblLanguage.font.withSize(fontSizeLabel2)
    }
    
    var languageChecked:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if languageChecked == "VietNam"{
            imgCountry.image = #imageLiteral(resourceName: "img_VN")
            lblLanguage.text = "Việt Nam"
            lblConfirm.text = "Bạn có chắc chọn ngôn ngữ tiếng Việt"
        } else if languageChecked == "Campuchia"{
            imgCountry.image = #imageLiteral(resourceName: "img_Cam")
            lblLanguage.text = "Campuchia"
            lblConfirm.text = "Bạn có chắc chọn ngôn ngữ Campuchia"
        }
        
        configHeadernameFontSize()
    }

}
