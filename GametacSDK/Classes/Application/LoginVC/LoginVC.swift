//
//  LoginVC.swift
//  AppsFlyer
//
//  Created by Linh Phan on 9/30/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import PopupDialog
import FBSDKCoreKit
import FBSDKLoginKit
import LocalAuthentication
import GoogleSignIn
import FirebaseCore

class LoginVC: UIViewController, GIDSignInDelegate/*, GIDSignInDelegate*/ {

    
    public var didCloseDialog:(Bool)->() = {_ in}
    
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegistry: UIButton!
    @IBOutlet weak var btnPlayWithoutLogin: UIButton!
    @IBOutlet weak var btnLoginFacebook: UIButton!
    @IBOutlet weak var btnLoginGoogle: UIButton!
    @IBOutlet weak var scrMain: UIScrollView!
    
    @IBAction func btnLogin(_ sender: Any) {
        login()
    }
    @IBAction func btnRegistry(_ sender: Any) {
        let vc = RegistryVC()
        vc.didRegistryDialogComplete = {
            self.didCloseDialog(false)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPlayWithoutLogin(_ sender: Any) {
        playWithoutLogin()
    }
    @IBAction func btnLoginFacebook(_ sender: Any) {
        loginFacebook()
    }
    /*
     On button login gooogle click, delegate to self
     */
    @IBAction func btnLoginGoogle(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    let fbLoginManager: LoginManager = LoginManager()
    let deviceToken = UIDevice.current.identifierForVendor?.uuidString
    
    func playWithoutLogin(){
        UserServices.sharedInstance.playWithoutLogin(device_id: deviceToken ?? "",
                                                     client_id: GametacSDK.sharedInstance.client_id,
                                                     client_secret: GametacSDK.sharedInstance.client_secret) { (msg, userInfo) in
                                                        switch msg.code {
                                                        case 200:
                                                            //debugPrint("Đăng nhập thành công")
                                                            //appDelegate().infoLogined = userInfo
                                                            NSAuthentication.sharedInstance.profile = userInfo

                                                            //appDelegate().createMenuView()
                                                            self.dismiss(animated: true) {
                                                                self.didCloseDialog(false)
                                                            }
                                                            
                                                        default:
                                                            self.showPopup(title: "Thông báo", msg: msg.message)
                                                        }
        }
    }
    
    
    func login(){
        
        UserServices.sharedInstance.login(login: tfUserName.text!,
                                          password: tfPassword.text!,
                                          client_id: GametacSDK.sharedInstance.client_id,
                                          client_secret: GametacSDK.sharedInstance.client_secret) { (msg, userInfo) in
                                            switch msg.code {
                                            case 200:
                                                print(userInfo)
                                                NSAuthentication.sharedInstance.profile = userInfo
                                                //appDelegate().infoLogined = userInfo
                                                //appDelegate().createMenuView()
                                                
                                            default:
                                                self.showPopup(title: "Thông báo", msg: msg.message)
                                            }
        }
    }
    
    
    /**
     Login with facebook button click
     */
    func loginFacebook(){
        fbLoginManager.logOut()
        // fbLoginManager.loginBehavior = .browser (remove login with browser)
        fbLoginManager.logIn(permissions: ["public_profile","email"], from: self) { (result, err) in
            if (err == nil) {
                if let _ = result{
                    debugPrint(result!.grantedPermissions)
                    if(result!.grantedPermissions.count != 0){
                        UserServices.sharedInstance.loginSocial(token: AccessToken.current?.tokenString ?? "", provider: "facebook", client_id: GametacSDK.sharedInstance.client_id, client_secret: GametacSDK.sharedInstance.client_secret, completion: { (msg, userProfile) in
                            switch msg.code {
                            case 200:
                                print(userProfile)
                                NSAuthentication.sharedInstance.profile = userProfile
                                
                                // Close login dialog
                                self.didCloseDialog(false)


                            default:
                                self.showPopup(title: "Thông báo", msg: msg.message)
                            }
                        })
                    }else{
                        // Result null
                        let popup = PopupDialog(title: "Thông báo", message: "Đăng nhập Facebook thất bại")
                        self.present(popup, animated: true)
                    }
                }else{
                    // Result null
                    let popup = PopupDialog(title: "Thông báo", message: "Đăng nhập Facebook thất bại")
                    self.present(popup, animated: true)
                }
            } else {
                let popup = PopupDialog(title: "Thông báo", message: "Đăng nhập Facebook thất bại")
                self.present(popup, animated: true)
            }
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            print(user.userID)
            print(user.authentication.idToken)
            print(user.authentication.accessToken)
            print(user.profile.name)
            print(user.profile.email)
            print(user.profile.imageURL(withDimension: 500))
            let id_token = user.authentication.idToken
            let access_token = user.authentication.accessToken
            let username = user.profile.name
            let avatar: String = user.profile.imageURL(withDimension: 500)!.absoluteString
            
            UserServices.sharedInstance.loginSocial(token: access_token ?? "", provider: "google", client_id: GametacSDK.sharedInstance.client_id, client_secret: GametacSDK.sharedInstance.client_secret, completion: { (msg, userProfile) in
                switch msg.code {
                case 200:
                    print(userProfile)
                    NSAuthentication.sharedInstance.profile = userProfile
                    //appDelegate().infoLogined = userProfile
                    //appDelegate().createMenuView()
                    
                default:
                    self.showPopup(title: "Thông báo", msg: msg.message)
                }
            })
        }
    }
    
    
    
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "Đóng", action: {
            
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    func configElementsView(){
        self.btnLogin.layer.cornerRadius = 5
        self.btnRegistry.layer.cornerRadius = 5
        self.btnPlayWithoutLogin.layer.cornerRadius = 5
        self.btnLoginFacebook.layer.cornerRadius = 5
        self.btnLoginGoogle.layer.cornerRadius = 5
        self.tfUserName.addShadowTextField()
        self.tfPassword.addShadowTextField()
        self.tfUserName.layer.borderWidth = 1
        self.tfUserName.layer.cornerRadius = 5
        self.tfUserName.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfPassword.layer.borderWidth = 1
        self.tfPassword.layer.cornerRadius = 5
        self.tfPassword.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tfUserName.delegate = self
        self.tfPassword.delegate = self
    }
    
    func removeObservers(){
        NotificationCenter.default.removeObserver(self)
    }
    func addObservers() {
        
   
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        

        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        scrMain.contentInset = UIEdgeInsets.zero
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo ,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height + 40, right: 0)
        scrMain.contentInset = contentInset
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        addObservers()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //Google delegate
        FirebaseApp.configure()

        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        self.hideKeyboard()
        self.configElementsView()
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfUserName.resignFirstResponder()
        tfPassword.resignFirstResponder()
        performAction()
        self.dismiss(animated: true, completion: nil)
        return true
    }
    func performAction() {
        login()
    }
}

extension UIView{
    func addShadowTextField(){
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        clipsToBounds = false
    }

}

