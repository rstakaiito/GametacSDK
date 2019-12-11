//
//  LaborPopupNoticeVC.swift
//  MobileLabor
//
//  Created by Kien Nguyen Duc on 9/11/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit

class PopupNotice: UIViewController {
    
    @IBOutlet weak var lblNoticeTitle: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    
    
    @IBAction func btnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.ifDismiss()
        pressedAction = true
        ifPressAction()
    }
    
    var ifPressAction:()->() = {}
    var ifDismiss:()->() = {}
    
    @IBOutlet weak var lblDes: UILabel!
    
    var desStr = "Phiên đăng nhập hết hạn"
    var buttonTitle = "Đăng nhập lại"
    var noticeTitle = "Thông báo"
    
    var pressedAction = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAction.setTitle(buttonTitle, for: .normal)
        lblDes.text = desStr
        lblNoticeTitle.text = noticeTitle
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        if pressedAction {
            return
        }
        
        self.ifDismiss()
    }
    
}
