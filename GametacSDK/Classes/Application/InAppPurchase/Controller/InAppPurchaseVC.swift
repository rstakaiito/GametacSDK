//
//  InAppPurchaseVC.swift
//  TestHero
//
//  Created by Kien Nguyen Duc on 11/20/19.
//  Copyright © 2019 Linh Phan. All rights reserved.
//

import UIKit
import StoreKit
import Alamofire
import SwiftyJSON
import PopupDialog
class InAppPurchaseVC: UIViewController {
    
    @IBOutlet weak var tblList: UITableView!
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    var products: [SKProduct] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        //Config data
        IAPService.sharedInstance.configData(client_id: 5, server_id: 1, player_id: 4, extra_data: "example")
        
        //Set product_id
        IAPService.sharedInstance.product_ids = ["com.newsoft.AppsFlyer"]
 
        self.getItems()

    }
    
    
    func getItems(){
        PKIAPHandler.shared.setProductIds(ids: IAPService.sharedInstance.product_ids)
        self.showIndicatorView("Đang tải ...")
        PKIAPHandler.shared.fetchAvailableProducts { (products)   in
            debugPrint(products)
            self.hideIndicatorView()
            self.products = products
            self.tblList.reloadData()
        }
    }
    
    func configTableView(){
        tblList.rowHeight = UITableView.automaticDimension
        tblList.tableFooterView = UIView()
        tblList.delegate = self
        tblList.dataSource = self
        self.tblList.register(UINib(nibName: "IAPCell", bundle: nil), forCellReuseIdentifier: "IAPCell")
    }
    
    func sendReceiptToServer(receiptData:String,completion:@escaping(MessageStruct)->()){
        
        //Config
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(NSAuthentication.sharedInstance.getToken())",
            "Accept": "application/json"
        ]
        
        debugPrint("POST  - : Header:\(headers)")
        let url = "https://api.vntac.vn/v1/payment/verify-apple-store-purchase"
        
        //SEND
        
        guard let clientId = IAPService.sharedInstance.client_id,
            let serverId = IAPService.sharedInstance.server_id,
            let playerId = IAPService.sharedInstance.player_id,
            let extraData = IAPService.sharedInstance.extra_data else {
            self.showPopup(title: "Thông báo", msg: "Missing IAP data config")
                return
        }
        
        let param:[String:Any] = ["receipt":receiptData,
                                  "client_id": clientId,
                                  "server_id": serverId,
                                  "player_id": playerId,
                                  "extra_data": extraData]
        
        debugPrint("POST  - \(url) : Sending \(param)")

        Alamofire.request(url,method: .post, parameters: param,encoding: URLEncoding.default,headers: headers).responseJSON{ response in
            
            print("\(url) : Response" )
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("\(url) : Data \n \(utf8Text)")
            }
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let errorService = MessageStruct(error: json["error"].boolValue, message: json["message"].stringValue, code: json["code"].intValue)
                debugPrint(json)
                completion(errorService)
                
            case .failure(let _):
                print("\(url) : Response error!" )
                let msg = MessageStruct(error: true, message: "Có vấn đề trong quá trình kết nối",code: 1010)
                completion(msg)
            }
        }
    }
    
    
    func validateReceipt(forTransaction transaction: SKPaymentTransaction) {
        guard let receiptURL = Bundle.main.appStoreReceiptURL else { return }
        guard let receipt = NSData(contentsOf: receiptURL) else { return }
        let receiptData = receipt.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        debugPrint("receiptData: \(receiptData)")
        IAPService.sharedInstance.receiptData = receiptData

        self.validateReceiptWithMyServer(receiptData: IAPService.sharedInstance.receiptData)
        
    }
    
    
    // Xác thực với VNTAC
    func validateReceiptWithMyServer(receiptData:String){
        self.showIndicatorView("Đang xử lý ...")
        self.sendReceiptToServer(receiptData: receiptData) { (msg) in
            self.hideIndicatorView()
            switch msg.code {
            case 200:
                self.showPopup(title: "Thành công", msg: msg.message)
            case 800:
                UserServices.sharedInstance.refreshToken(completion: { (msg, userInfo) in
                    switch msg.code {
                    case 200:
                        debugPrint("Refresh token success")
                        //appDelegate().infoLogined = userInfo
                        NSAuthentication.sharedInstance.profile = userInfo
                        self.validateReceiptWithMyServer(receiptData: receiptData)
                    default:
                        debugPrint("Refresh token failed")
                        self.reLogin()
                    }
                })

            default:
                self.showPopup(title: "Thông báo", msg: msg.message)
            }
        }
    }
    
    
    func showPopup(title:String, msg: String){
        let popup = PopupDialog(title: title, message: msg)
        popup.addButton(PopupDialogButton.init(title: "OK", action: {
            
        }))
        self.present(popup, animated: true, completion: nil)
    }
}
extension InAppPurchaseVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PKIAPHandler.shared.purchase(product: self.products[indexPath.row]) { (alert, product, transaction) in
            
            if let tran = transaction, let prod = product {
                debugPrint(tran.transactionIdentifier)
                self.validateReceipt(forTransaction: tran)
            }
            
            debugPrint(alert.message)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IAPCell", for: indexPath) as! IAPCell
        let product = products[(indexPath as NSIndexPath).row]
        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

