//
//  SecondViewController.swift
//  ITRexTestTask
//
//  Created by Павел Кулицкий on 11.02.22.
//

import UIKit

class SecondViewController: UIViewController {
    
    let pickerComponentWidth = UIScreen.main.bounds.maxY - 20
    let pickerRowHeight = UIScreen.main.bounds.maxX/10
    
    let pickerViewRows = ["BYN 🇧🇾,code: 993",
                          "RUS 🇷🇺,code: 643",
                          "EUR 🇪🇺,code: 978",
                          "USD 🇺🇸,code: 840"]
    
    //MARK: - create UI
    private let pickerView: UIPickerView = {
        var pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private let okButton: UIButton = {
        var button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.orange, for: .highlighted)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .systemGray4
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        pickerSubscribe()
        
        setupViews()
        setConstraints()
        
        view.backgroundColor = .white
    }
    
    @objc private func okButtonAction() {
        
        DispatchQueue.main.async {
            FirstViewController.currentCurrency = self.pickerView.selectedRow(inComponent: 0)
        }
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }

    }
    
    //MARK: - Setup Views
    private func setupViews() {
        view.addSubview(pickerView)
        view.addSubview(okButton)
    }

    //MARK: - Set constrains
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.widthAnchor.constraint(equalToConstant: pickerComponentWidth),
            pickerView.heightAnchor.constraint(equalToConstant: pickerRowHeight*3),
            
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 20),
            okButton.widthAnchor.constraint(equalToConstant: 200),
            okButton.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }

}

//MARK: - PICKER VIEW DELEGATE & DATASOURCE
extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func pickerSubscribe() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerViewRows.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerViewRows[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
            case 0: print("row: \(row)")
            case 1: print("row: \(row)")
            case 2: print("row: \(row)")
            case 3: print("row: \(row)")
        default: break
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        pickerRowHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        pickerComponentWidth
    }
    
}
