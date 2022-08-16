//
//  UITextField.swift
//  ITRexTestTask
//
//  Created by Павел Кулицкий on 11.02.22.
//

import Foundation
import UIKit

extension UITextField {
    
    
    convenience init(_ tag: Int, _ imageView: UIImageView, _ codeLabel: UILabel, _ button: UIButton) {
        self.init()
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.keyboardType = .decimalPad
        self.returnKeyType = .done
        self.placeholder = "0.00"
        self.borderStyle = .line
        self.font = UIFont(name: "Times New Roman", size: 30)
        self.tag = tag
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setLeftView(imageView, codeLabel)
        self.setRightView(button, tag)
    }
    
    //Left view for uitextfield
    private func setLeftView(_ imageView: UIImageView, _ codeLabel: UILabel) {
        
        let textFieldHeight = UIScreen.main.bounds.maxY/15
        let textFieldwidth = UIScreen.main.bounds.maxX - 20
        
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = true
        outerView.frame = CGRect(x: 0, y: 0, width: textFieldwidth/5 + 5, height: textFieldHeight)
        
        switch self.tag {
        case 1: codeLabel.text = "993"
            imageView.image = UIImage(named: "byn")
        case 2: codeLabel.text = "840"
            imageView.image = UIImage(named: "usd")
        default: break
        }
        
        codeLabel.textAlignment = .center
        codeLabel.translatesAutoresizingMaskIntoConstraints = true
        codeLabel.frame = CGRect(x: 1, y: 1, width: textFieldwidth/10, height: textFieldHeight-2)
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = true
        imageView.frame = CGRect(x: 2 + textFieldwidth/10 , y:1 , width: textFieldwidth/10, height: textFieldHeight-2)

        outerView.addSubview(imageView)
        outerView.addSubview(codeLabel)
        
        leftView = outerView
        
    }
    
    
    //Right view for uitextfield
    private func setRightView(_ rightButton: UIButton,_ tag: Int) {
        
        rightButton.setTitle("change", for: .normal)
        rightButton.setTitleColor(.orange, for: .highlighted)
        rightButton.setTitleColor(.black, for: .normal)
        rightButton.layer.borderColor = UIColor.systemGray.cgColor
        rightButton.layer.borderWidth = 1
        rightButton.backgroundColor = .systemGray6
        rightButton.layer.cornerRadius = 5
        rightButton.tag = tag
        
        let textFieldHeight = UIScreen.main.bounds.maxY/15
        let textFieldwidth = UIScreen.main.bounds.maxX - 20
        
        let outerView = UIView()
        outerView.translatesAutoresizingMaskIntoConstraints = true
        outerView.frame = CGRect(x: textFieldwidth*4/5, y: 0,
                                 width: textFieldwidth/5 + 5, height: textFieldHeight)
        
        rightButton.translatesAutoresizingMaskIntoConstraints = true
        rightButton.frame = CGRect(x: outerView.bounds.maxX * 0.1, y: outerView.bounds.maxY * 0.1,
                                   width: outerView.bounds.maxX * 0.8, height: outerView.bounds.maxY * 0.8)
        
        outerView.addSubview(rightButton)
        
        rightView = outerView
    }

}
