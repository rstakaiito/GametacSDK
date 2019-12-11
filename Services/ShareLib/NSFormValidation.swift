//
//  NSFormValidation.swift
//  CeoIntegration
//
//  Created by Kien Nguyen Duc on 4/6/18.
//  Copyright © 2018 newsoft. All rights reserved.
//

import UIKit

enum NSFormValidationRule{
    case email
    case notnull
    case isNumber
    case minLength(Int)
    case phone
}

struct NSFormValidationCheckList{
    var element:UITextField
    var rule:NSFormValidationRule
}

class NSFormValidation: NSObject {
    
    private var checkList = [NSFormValidationCheckList]()
    
     func addTarget(_ target:UITextField?,rules:[NSFormValidationRule]){
        if let textField = target{
            for rule in rules {
                self.checkList.append(NSFormValidationCheckList.init(element: textField, rule: rule))
            }
        }
    }
    
    private func execCheckPhone(content: String) -> Bool {
        let phoneRegEx = "^(01[2689]|09|08)[0-9]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        let result =  phoneTest.evaluate(with: content)
        return result
    }
    
    private func execCheckEmail(content:String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: content)
    }
    
    private func execCheckMinLength(content:String, minLength:Int)->Bool{
        return (content.trimmingCharacters(in: .alphanumerics).count > minLength)
    }
    
    var onError:(UITextField,String)->Void = {_,_ in }
    var onNonError:(UITextField)->Void = {_ in}
    
    
   private func test(element:UITextField, rule:NSFormValidationRule)->Bool{
        var isValid = true
        let stringValue = element.text ?? ""
        switch rule {
        case .email:
            isValid = self.execCheckEmail(content:stringValue)
        case .notnull:
            return (!stringValue.isEmpty)
        case .minLength(let length):
            return self.execCheckMinLength(content: stringValue, minLength: length)
        case .isNumber:
            print("hjhj")
            
        case .phone:
            return self.execCheckPhone(content: stringValue)
    }
        return isValid
    }
    
    
    func getErrorMessage(rule:NSFormValidationRule)->String{
        switch rule {
        case .email:
            return "Vui lòng điền email"
        case .notnull:
            return "Vui lòng điền nội dung"
        case .minLength(let num):
            return "Vui lòng nhập nhiều hơn \(num) ký tự"
        case .isNumber:
            return "Vui lòng nhập chữ số"
        case .phone:
            return "Số điện thoại không đúng"
        }
    }
    
    func inlineValidation(_ textfield:UITextField){
        let inlineElementFound = self.checkList.filter { (checkListItem) -> Bool in
            return (checkListItem.element == textfield)
        }
        for item in inlineElementFound {
            // Do validation it
            let result = self.test(element: item.element, rule: item.rule)
            if(!result){
                self.onError(item.element,self.getErrorMessage(rule: item.rule))
                return
            }else{
                self.onNonError(item.element)
            }
        }
    }
    
    func checkValidation()->Bool{
        for item in self.checkList {
            // Do validation it
            let result = self.test(element: item.element, rule: item.rule)
            if(!result){
                self.onError(item.element,self.getErrorMessage(rule: item.rule))
                return false
            }else{
                self.onNonError(item.element)
            }
        }
        return true
    }
}
