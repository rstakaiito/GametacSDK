//
//  ViewController.swift
//  GametacSDK
//
//  Created by rstakaiito on 12/12/2019.
//  Copyright (c) 2019 rstakaiito. All rights reserved.
//

import UIKit
import GametacSDK

class ViewController: UIViewController {
    
    
    
    
    
    // Example methods
    
    private func sampleShowLoginDialog(){
         
        GametacSDK.sharedInstance.showLoginDialog(self) { (isCancel) in
            
            if(isCancel){
                print("User click to close button and do not make anything")
            }else{
                print("User login success")
                let userInfo = GametacSDK.sharedInstance.getLoginedInfo()
                print(userInfo)
            }
        }
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @IBAction func didTouchLogin(){
        self.sampleShowLoginDialog()
    }
}

