//
//  UIViewExtension.swift
//  iTower
//
//  Created by Nguyen Thanh Tung on 4/12/17.
//  Copyright © 2017 Nguyen Thanh Tung. All rights reserved.
//

import UIKit



@IBDesignable
class FormTextField: UITextField {
    
    @IBInspectable var inset: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    @IBInspectable var linesWidth: CGFloat = 1.0 { didSet{ drawLines() } }
    
    @IBInspectable var linesColor: UIColor = UIColor.black { didSet{ drawLines() } }
    
    @IBInspectable var leftLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var rightLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var bottomLine: Bool = false { didSet{ drawLines() } }
    @IBInspectable var topLine: Bool = false { didSet{ drawLines() } }
    
    
    
    func drawLines() {
        
        if bottomLine {
            add(line: CGRect(0.0, frame.size.height - linesWidth, frame.size.width, linesWidth))
        }
        
        if topLine {
            add(line: CGRect(0.0, 0.0, frame.size.width, linesWidth))
        }
        
        if rightLine {
            add(line: CGRect(frame.size.width - linesWidth, 0.0, linesWidth, frame.size.height))
        }
        
        if leftLine {
            add(line: CGRect(0.0, 0.0, linesWidth, frame.size.height))
        }
        
    }
    
    typealias Line = CGRect
    private func add(line: Line) {
        let border = CALayer()
        border.frame = line
        border.backgroundColor = linesColor.cgColor
        layer.addSublayer(border)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        drawLines()
    }
    
}
extension UIView {
    
    //Chuyển view thành đường nét đứt
    func addDashedLine(color: UIColor = .lightGray) {
        layer.sublayers?.filter({ $0.name == "DashedTopLine" }).map({ $0.removeFromSuperlayer() })
        backgroundColor = .clear
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [4, 4]
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
    
    func createBlurView()->(UIView){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.cornerRadius = 16
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurEffectView.alpha = 0.92
        return blurEffectView
    }
    
    
}
