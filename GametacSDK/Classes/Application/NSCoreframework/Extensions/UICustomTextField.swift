//
//  UICustomTextField.swift
//  PuriTrak
//
//  Created by Phan Hải Linh on 8/30/18.
//  Copyright © 2018 Phan Hai Linh. All rights reserved.
//

import UIKit

class UICustomTextField: UITextField {
//--//
    
//---//
//---------------------placeholder & text-----------------------------//
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
//----------------------------------------------------------------------------//
//----------------------------image left view------------------------------//
    @IBInspectable
    var leftImage: UIImage?{
        didSet {
            updateView()
        }
    }
    
    func updateView(){
        if let image = leftImage {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 20, height: 25))
            imageView.image = image
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25 ))
            view.addSubview(imageView)
            
            leftView = view
            
        } else {
            leftViewMode = .never
        }
    }
//--------------------------------------------------------------------------//
//----------------------------image right view------------------------------//
    @IBInspectable
    var rightImage: UIImage?{
        didSet {
            updateViewRight()
        }
    }

    func updateViewRight(){
        if let image = rightImage {
            rightViewMode = .always
            let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 25, height: 25))
            imageView.image = image
            let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 25 ))
            view.addSubview(imageView)
            rightView = view
        } else {
            rightViewMode = .never
        }
    }
//--------------------------------------------------------------------------//
}
extension UITextField {
    
    @IBInspectable var paddingLeft: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRight: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    //thêm nút done ở toolbar keyboard
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Ẩn", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
    // Màu của place holder
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    
    
}
