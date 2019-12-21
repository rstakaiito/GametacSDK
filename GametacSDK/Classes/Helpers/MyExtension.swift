//
//  MyExtension.swift
//  iTower
//
//  Created by Nguyen Thanh Tung on 4/14/17.
//  Copyright © 2017 Nguyen Thanh Tung. All rights reserved.
//

import UIKit
import Kingfisher
import PopupDialog
import NVActivityIndicatorView
extension UIViewController{
    
    func reLogin(){
        let vc = PopupNotice()
        vc.ifDismiss = {
            let vc = LoginVC()
            UserDefaults.standard.setValue(nil, forKey: "access_token")
            UserDefaults.standard.setValue(nil, forKey: "refresh_token")
            let navigationController = UINavigationController(rootViewController: vc)
            //appDelegate().window?.rootViewController = navigationController
            self.navigationController?.popToRootViewController(animated: true)
        }
        let popup = PopupDialog(viewController: vc)
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func showIndicatorView(_ title: String) {
        var activityIndicator = UIActivityIndicatorView()
        var strLabel = UILabel()
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 14, weight: .medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        effectView.tag = 219
        view.addSubview(effectView)
    }
    
    func hideIndicatorView(){
        let activityIndicator = view.viewWithTag(219) as? UIVisualEffectView
        activityIndicator?.removeFromSuperview()
    }
    
    
    func showUpdatePopup(){
        if NSAuthentication.sharedInstance.profile.provider == "app_device"{
            Timer.scheduledTimer(timeInterval: 10, target: self, selector:#selector(showPopup) , userInfo: nil, repeats: true)
        }
    }
    
    @objc func showPopup(){
        let vc = SwitchAccountVC()
        let popup = PopupDialog(viewController: vc, transitionStyle: .zoomIn)
        self.present(popup, animated: true, completion: nil)
    }
    
    
    func showActivityIndicator(type: NVActivityIndicatorType = .ballRotateChase, color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) {
            let activityIndicator = NVActivityIndicatorView(frame: CGRect(UIScreen.main.bounds.size.width/2 - 30, UIScreen.main.bounds.size.height/2 - 30, 60, 60), type: type, color: color, padding: 0)
            activityIndicator.tag = 1993
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
    }
    
    func hideActivityIndicator(){
        let activityIndicator = view.viewWithTag(1993) as? NVActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
    
    
    func showLoadingView(type: NVActivityIndicatorType = .lineScale, color: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(UIScreen.main.bounds.size.width/2 - 50, UIScreen.main.bounds.size.height - 60, 100, 30), type: type, color: color, padding: 0)
        activityIndicator.tag = 219
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func hideLoadingView(){
        let activityIndicator = view.viewWithTag(219) as? NVActivityIndicatorView
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
    }
    
    
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboardInputBar(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    func hideKeyboardCancelTouchView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
//    func reLogin(title:String, msg: String){
//        let popup = PopupDialog(title: title, message: msg)
//        
//        popup.addButton(PopupDialogButton.init(title: "Đăng nhập lại", action: {
//            let vc = LoginScreenVC()
//            let navigationController = UINavigationController(rootViewController: vc)
//            appDelegate().window?.rootViewController = navigationController
//            self.navigationController?.popToRootViewController(animated: true)
//            
////            UserService.sharedInstance.postLog(type: "error", log: "func reLogin(title:String, msg: String)")
//
//            
//        }))
//        self.present(popup, animated: true, completion: nil)
//    }
    
//    func checkNetWorkAvailble(){
//        
//        var timerForReChecking:Timer?
//        switch Network.reachability.status {
//        case .unreachable:
//            let vc = NoInternetAlertSubview()
//            vc.ifPressReAction = {
//                self.dismiss(animated: true, completion: nil)
//                timerForReChecking = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false, block: { (timer) in
//                    self.checkNetWorkAvailble()
//                })
//            }
//            let popup = PopupDialog(viewController: vc,tapGestureDismissal: false,panGestureDismissal:false)
//            self.present(popup, animated: true, completion: nil)
//            //        case .wwan:
//            //            view.backgroundColor = .yellow
//            //        case .wifi:
//        //            view.backgroundColor = .green
//        default:
//            self.dismiss(animated: true, completion: nil)
//            debugPrint("Network availble")
//        }
//    }
}
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func toString(_ format:String? = "yyyy-MM-dd HH:mm:ss")->String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = format
        //let myString = formatter.string(from: Date())
        // convert your string to date
        // let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        //formatter.dateFormat = "dd/MM/yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: self)
        return myStringafd
    }
    
    func timeAgoSinceDate(numericDates:Bool) -> String {
        let date = self
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) năm nữa"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 năm nữa"
            } else {
                return "Năm tới"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) tháng nữa"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 tháng nữa"
            } else {
                return "Tháng tới"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) tuần nữa"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "Tuần Sau"
            } else {
                return "Tuần sau"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) ngày nữa"
        } else if (components.day! >= 1){
            if (numericDates){
                return "Ngày mai"
            } else {
                return "Ngày mai"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) giờ nữa"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) phút nữa"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 phút nữa"
            } else {
                return "1 phút nữa"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) giây nữa"
        } else {
            return "Bây giờ"
        }
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

public extension UIDevice {
    
    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod Touch 5"
            case "iPod7,1":                                 return "iPod Touch 6"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad6,11", "iPad6,12":                    return "iPad 5"
            case "iPad7,5", "iPad7,6":                      return "iPad 6"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }
        
        return mapToDevice(identifier: identifier)
    }()
    
}

@IBDesignable class TextViewWithInsets: UITextView {
    
    @IBInspectable var topInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: topInset, left: self.contentInset.left, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }
    
    @IBInspectable var bottmInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: bottmInset, right: self.contentInset.right)
        }
    }
    
    @IBInspectable var leftInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: leftInset, bottom: self.contentInset.bottom, right: self.contentInset.right)
        }
    }
    
    @IBInspectable var rightInset: CGFloat = 0 {
        didSet {
            self.contentInset = UIEdgeInsets(top: self.contentInset.top, left: self.contentInset.left, bottom: self.contentInset.bottom, right: rightInset)
        }
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

@IBDesignable
class Dot:UIView
{
    @IBInspectable var mainColor: UIColor = UIColor.blue
        {
        didSet { print("mainColor was set here") }
    }
    @IBInspectable var ringColor: UIColor = UIColor.orange
        {
        didSet { print("bColor was set here") }
    }
    @IBInspectable var ringThickness: CGFloat = 4
        {
        didSet { print("ringThickness was set here") }
    }
    
    @IBInspectable var isSelected: Bool = true
    
    override func draw(_ rect: CGRect)
    {
        let dotPath = UIBezierPath(ovalIn:rect)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = dotPath.cgPath
        shapeLayer.fillColor = mainColor.cgColor
        layer.addSublayer(shapeLayer)
        
        if (isSelected) { drawRingFittingInsideView(rect: rect) }
    }
    
    internal func drawRingFittingInsideView(rect: CGRect)->()
    {
        let hw:CGFloat = ringThickness/2
        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: hw,dy: hw) )
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = ringColor.cgColor
        shapeLayer.lineWidth = ringThickness
        layer.addSublayer(shapeLayer)
    }
}


extension CALayer {
    
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        
        border.backgroundColor = color.cgColor;
        
        self.addSublayer(border)
    }
    
}

extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension CGSize{
    init(_ width:CGFloat,_ height:CGFloat) {
        self.init(width:width,height:height)
    }
}
extension CGPoint{
    init(_ x:CGFloat,_ y:CGFloat) {
        self.init(x:x,y:y)
    }
}

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}


@IBDesignable
class RoundedButton:UIButton {
    
    @IBInspectable var xcornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
}

extension UIImageView {
    func loadImage(url:String?,placeHolderImage:UIImage? = #imageLiteral(resourceName: "ic_user_default"), onFailImage:UIImage? = #imageLiteral(resourceName: "ic_user_default")){
        if let url = url{
            if(!url.isEmpty){
                self.kf.setImage(with: URL(string:url), placeholder: placeHolderImage,completionHandler: { (img, error, cache, url) in
                    if img == nil{
                        self.image = onFailImage
                    }
                })
            }else{
                self.image = onFailImage
            }
        }else{
            self.image = onFailImage
        }
    }
}

class NSShadownButton:UIButton{

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let shadowLayer = UIView(frame: self.frame)
        shadowLayer.backgroundColor = UIColor.clear
        shadowLayer.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 3)
        shadowLayer.layer.shadowOpacity = 0.4
        shadowLayer.layer.shadowRadius = 3
        shadowLayer.layer.masksToBounds = true
        shadowLayer.clipsToBounds = false
        self.superview?.addSubview(shadowLayer)
        self.superview?.sendSubviewToBack(shadowLayer)
        self.shadownLayer = shadowLayer
        if(self.isHidden){
            self.shadownLayer?.isHidden = true
        }
    }
    
    var shadownLayer:UIView?
    
    var doHide: Bool {
        get {
            return super.isHidden
        }
        set(val) {
            self.shadownLayer?.isHidden = val
            super.isHidden = val
            
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}



extension UIView{
    func animationZoom(scaleX: CGFloat, y: CGFloat) {
        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
    }
    
    func animationRoted(angle : CGFloat) {
        self.transform = self.transform.rotated(by: angle)
    }
}

@IBDesignable
class LeftAlignedIconButton: UIButton {
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let titleRect = super.titleRect(forContentRect: contentRect)
        let imageSize = currentImage?.size ?? .zero
        let availableWidth = contentRect.width - imageEdgeInsets.right - imageSize.width - titleRect.width
        return titleRect.offsetBy(dx: round(availableWidth / 2), dy: 0)
    }
}

@IBDesignable
class RightAlignedIconButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .right
        
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        
        let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: availableWidth / 2)
    }
}
extension Date {
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let yearAgo = calendar.date(byAdding: .year, value: -365, to: Date())!
        
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) giây trước"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) phút trước"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) giờ trước"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) ngày trước"
        } else if yearAgo < self {
            let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
            return "\(diff) tuần trước"
        }
        let diff = Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
        return "\(diff) năm trước"
    }
}
