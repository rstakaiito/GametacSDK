//
//  CustomSegmentedControl.swift
//  CeoIntegration
//
//  Created by Kien Nguyen Duc on 3/23/18.
//  Copyright © 2018 newsoft. All rights reserved.
//

import UIKit

@IBDesignable
class CustomSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentindex = 0
    var font: UIFont!

    @IBInspectable
    override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    override var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet{
            updateView()
        }
    }
    

    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = .darkGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }

    func updateView(){
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview()}
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        
        for buttontitle in buttonTitles {
            let button = UIButton(type: .custom)

            button.adjustsImageWhenHighlighted = false
            button.titleLabel?.font = UIFont(name: "Avenir Next", size: 13)
            button.setTitle(buttontitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)

            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))

        selector.layer.cornerRadius = frame.height/2
        
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        updateView()
    }
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.height/2
    }
    @objc func buttonTapped(button: UIButton){

        for (buttonIndex,btn) in buttons.enumerated() {
            
            btn.setTitleColor(textColor, for: .normal)
            btn.adjustsImageWhenHighlighted = false

            if btn == button {
                
                selectedSegmentindex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
    }
}
