//
//  FirstViewController.swift
//  ITRexTestTask
//
//  Created by Павел Кулицкий on 11.02.22.
//

import UIKit
import Foundation

class FirstViewController: UIViewController {

    private lazy var tfArray = [firstTextField, secondTextField]
    private lazy var leftImageArray = [leftImageView1,leftImageView2]
    private lazy var codeLabelArray = [codeLabel1,codeLabel2]
    
    private let codeArray = ["993","643","978","840"]
    private let currencyArray = ["byn", "rus", "eur", "usd"]
    
    private var firstTFCurrency: String = "byn"
    private var secondTFCurrency: String = "usd"
    
    private var coefIn: Float = 0.0
    
    static var currentCurrency: Int = 0
    private var currentCourse = Currency()
    static var isActive: Int = 0
    
    //MARK: - create UI
    private var firstTextField = UITextField()
    private let leftImageView1 = UIImageView()
    private let codeLabel1 = UILabel()
    private let rightButton1 = UIButton()
    
    private var secondTextField = UITextField()
    private let leftImageView2 = UIImageView()
    private let codeLabel2 = UILabel()
    private let rightButton2 = UIButton()
    
    private let appNameLabel: UILabel = {
        var label = UILabel()
        label.text = "Currency converter"
        label.textAlignment = .center
        label.font = UIFont(name: "GillSans-Bold", size: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        var label = UILabel()
        label.text = "Author: Kylitsky Pavel"
        label.textAlignment = .center
        label.font = UIFont(name: "TimesNewRoman", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let versionLabel: UILabel = {
        var label = UILabel()
        label.text = "Version 1.0"
        label.textAlignment = .center
        label.font = UIFont(name: "TimesNewRoman", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        cleanTextFields()
        
        if FirstViewController.isActive != 0 {
            codeLabelArray[FirstViewController.isActive-1].text = codeArray[FirstViewController.currentCurrency]
            leftImageArray[FirstViewController.isActive-1].image = UIImage(named: currencyArray[FirstViewController.currentCurrency])
            if FirstViewController.isActive == 1 {
                firstTFCurrency = currencyArray[FirstViewController.currentCurrency]
            } else {
                secondTFCurrency = currencyArray[FirstViewController.currentCurrency]
            }
            self.getCourse(firstCurrency: self.firstTFCurrency, secondCurrency: self.secondTFCurrency)
        }
        
        if firstTFCurrency == secondTFCurrency {
            self.coefIn = 1
            print("coefIn : \(coefIn)")
        }
    }
    
    //MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        textFieldsSetting()
        setupViews()
        setConstraitns()
        
        firstTextField.becomeFirstResponder()
 
        NetworkManager.getCurrencyData { cur in
            self.currentCourse.append(cur)
            print(self.currentCourse)
            self.coefIn = 1/Float(self.currentCourse[0].usdOut)!
        }
        
       
        
    }
    
    
    //MARK: - функция получения курса по текущим полям
    private func getCourse(firstCurrency inCurrency: String, secondCurrency outCurrency: String) {
        
        if inCurrency == "byn" {
            switch outCurrency {
                case "eur": self.coefIn = 1/Float(currentCourse[0].eurIn)!
                case "usd": self.coefIn = 1/Float(currentCourse[0].usdIn)!
                case "rus": self.coefIn = 1/Float(currentCourse[0].rubIn)! * 100
            default: break
            }
        } else {
            switch inCurrency {
                case "eur":
                switch outCurrency {
                    case "byn": self.coefIn = Float(currentCourse[0].eurOut)!
                    case "rus": self.coefIn = Float(currentCourse[0].rubEUROut)!
                    case "usd": self.coefIn = Float(currentCourse[0].usdEUROut)!
                default: break
                }
                case "rus":
                switch outCurrency {
                    case "byn": self.coefIn = Float(currentCourse[0].rubOut)! / 100
                    case "eur": self.coefIn = Float(currentCourse[0].rubEURIn)!
                    case "usd": self.coefIn = Float(currentCourse[0].usdRUBOut)!
                default: break
                }
                case "usd":
                switch outCurrency {
                    case "byn": self.coefIn = Float(currentCourse[0].usdOut)!
                    case "rus": self.coefIn = Float(currentCourse[0].usdRUBIn)!
                    case "eur": self.coefIn = Float(currentCourse[0].usdEURIn)!
                default: break
                }
            default: break
            }
            
        }
        
    }
    
    //MARK: - Change button action
    @objc private func changeButtonAction(_ sender: UIButton) {
        switch sender.tag {
            case 1: FirstViewController.isActive = 1
            case 2: FirstViewController.isActive = 2
        default: break
        }
        let vc = SecondViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - TextFields Setting
    private func textFieldsSetting() {
        
        firstTextField = UITextField(1, leftImageView1, codeLabel1, rightButton1)
        secondTextField = UITextField(2, leftImageView2, codeLabel2, rightButton2)
        
        firstTextField.delegate = self
        secondTextField.delegate = self
        
        rightButton1.addTarget(self, action: #selector(changeButtonAction(_:)), for: .touchUpInside)
        rightButton2.addTarget(self, action: #selector(changeButtonAction(_:)), for: .touchUpInside)
    }
    
    private func cleanTextFields() {
        firstTextField.text = ""
        secondTextField.text = ""
    }
    
    
    //MARK: - Setup Views
    private func setupViews() {
        
        view.addSubview(firstTextField)
        view.addSubview(secondTextField)
        view.addSubview(appNameLabel)
        view.addSubview(versionLabel)
        view.addSubview(authorLabel)
    }
    
    //MARK: - Constraists
    private func setConstraitns() {
        
        let textFieldHeight = UIScreen.main.bounds.maxY/15
        let textFieldWidth = UIScreen.main.bounds.maxX - 20
        
        NSLayoutConstraint.activate([
            firstTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstTextField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            firstTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            secondTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 15),
            secondTextField.widthAnchor.constraint(equalToConstant: textFieldWidth),
            secondTextField.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: textFieldHeight),
            appNameLabel.widthAnchor.constraint(equalToConstant: textFieldWidth),
            appNameLabel.heightAnchor.constraint(equalToConstant: textFieldHeight),
            
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: textFieldHeight/2),
            authorLabel.widthAnchor.constraint(equalToConstant: textFieldWidth),
            authorLabel.heightAnchor.constraint(equalToConstant: textFieldHeight/2),
            
            versionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            versionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor),
            versionLabel.widthAnchor.constraint(equalToConstant: textFieldWidth),
            versionLabel.heightAnchor.constraint(equalToConstant: textFieldHeight/2),
        ])
        

    }
    
    //MARK: - Validation for textFields
    private func setTextField(textField: UITextField,range: NSRange, string: String) {
      
            let text = (textField.text ?? "") + string
            var result: String!
        
            if text.count > 9 { return }
            
            if range.length == 1 {
                if text.count == 0 {
                    cleanTextFields()
                    return
                } else {
                    let end = text.index(text.startIndex, offsetBy: text.count-1)
                    result = String(text[text.startIndex..<end])
                }
            } else {
                result = text
            }
        
            textField.text = result
        
            guard let _ =  Float(result) else {
                cleanTextFields()
                return }
        
        switch textField.tag {
            case 1:
            getCourse(firstCurrency: firstTFCurrency, secondCurrency: secondTFCurrency)
            secondTextField.text = String(format: "%.2f", Float(result)! * coefIn)
            case 2:
            getCourse(firstCurrency: secondTFCurrency, secondCurrency: firstTFCurrency)
            firstTextField.text = String(format: "%.2f", Float(result)! * coefIn)
        default: break
        }
    }
}


//MARK: - Text Field DELEGATE
extension FirstViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        setTextField(textField: textField, range: range, string: string)
        
        return false
    }
    
}
