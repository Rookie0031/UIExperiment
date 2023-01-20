//
//  UITextFieldExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

extension UITextField {
    static func makeBasicTextField(placeholder: String, characterLimit: Int) -> UITextField {
        let textField: UITextField = {
            
            let textField = UITextField(frame: .zero)
            textField.constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
            textField.constraint(.heightAnchor, constant: DeviceSize.width * 0.9 * 0.15)
            
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 14, weight: .light)])
            
            textField.maxCount = characterLimit
            textField.layer.borderWidth = 2
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = UIColor.orange.cgColor
            
            textField.leftView = EmptyView()
            
            textField.rightViewMode = .never
            textField.leftViewMode = .always
            return textField
        }()
        return textField
    }
}

extension UITextField {
    struct MaxCount {
        static var number: Int = 10
    }
    var maxCount: Int {
        get {
            MaxCount.number
        }
        set(newValue) {
            MaxCount.number = newValue
        }
    }
}

extension UITextField {
    static func checkDuplication() -> Bool {
        return true
    }
}
