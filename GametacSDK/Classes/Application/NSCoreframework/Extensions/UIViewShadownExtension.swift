//
//  UIViewShadownExtension.swift
//  CeoIntegration
//
//  Created by Duong Viet Cuong on 2/12/18.
//  Copyright © 2018 newsoft. All rights reserved.
//

import UIKit



extension UIView{

    func addShadowWithCornorRadius(cornerRadius: CGFloat,fillColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)){
        
        
        let shadowLayer = CAShapeLayer.init()
        shadowLayer.path = UIBezierPath.init(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.16)
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2, height: 2)
        shadowLayer.shadowOpacity = 0.6
        shadowLayer.shadowRadius = 4
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addShadowForButton(){
        layer.shadowOffset = CGSize(3, 3)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    public func addShadowForCell(){
        layer.shadowOffset = CGSize(1, 1)
        layer.shadowColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 0.08)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addShadowForCellOrder(){
        layer.shadowOffset = CGSize(10, 10)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.07)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.8
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addShadow(){
        layer.shadowOffset = CGSize(3, 3)
        layer.shadowColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.34
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addShadowLoginButton(){
        layer.shadowOffset = CGSize(3, 3)
        layer.shadowColor = #colorLiteral(red: 0.2235294118, green: 0.5960784314, blue: 0.3725490196, alpha: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addShadowForView(){
        layer.shadowOffset = CGSize(2, 2)
        layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addShadowForCellService(){
        layer.shadowOffset = CGSize(2, 2)
        layer.shadowColor = #colorLiteral(red: 0.9215686275, green: 0.9137254902, blue: 0.9843137255, alpha: 1)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    func addShadowLeftMenu(){
        layer.shadowOffset = CGSize(0.5, 0)
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 6
        layer.masksToBounds = false
        clipsToBounds = false
    }
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func fadeIn(duration:Double?){
        self.alpha = 0.1
        self.isHidden = false
        UIView.animate(withDuration: duration ?? 0.3, animations: {
            self.alpha = 1
        }) { (done) in
            // Nothing
        }
    }
    
    func fadeOut(duration:Double?){
        UIView.animate(withDuration: duration ?? 0.3, animations: {
            self.alpha = 0.3
        }) { (done) in
            // Nothing
        }
    }
    
    
    
    //    @IBInspectable
    //    var shadowRadius: CGFloat {
    //        get {
    //            return layer.shadowRadius
    //        }
    //        set {
    //            layer.shadowRadius = newValue
    //        }
    //    }
    //
    //    @IBInspectable
    //    var shadowOpacity: Float {
    //        get {
    //            return layer.shadowOpacity
    //        }
    //        set {
    //            layer.shadowOpacity = newValue
    //        }
    //    }
    //
    //    @IBInspectable
    //    var shadowOffset: CGSize {
    //        get {
    //            return layer.shadowOffset
    //        }
    //        set {
    //            layer.shadowOffset = newValue
    //        }
    //    }
    //
    //    @IBInspectable
    //    var shadowColor: UIColor? {
    //        get {
    //            if let color = layer.shadowColor {
    //                return UIColor(cgColor: color)
    //            }
    //            return nil
    //        }
    //        set {
    //            if let color = newValue {
    //                layer.shadowColor = color.cgColor
    //            } else {
    //                layer.shadowColor = nil
    //            }
    //        }
    //    }
}
