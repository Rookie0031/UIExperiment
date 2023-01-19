//
//  UITextFieldExtension.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

extension UITextField {
    static func makeBasicTextField(placeHolder: String, characterLimit: Int, width: CGFloat? = nil, height: CGFloat? = nil) -> UITextField {
        let textField: UITextField = {
            
            let width = UIScreen.main.bounds.width * 0.85
            let height = width * 0.15
            
            let textField = UITextField(frame: .zero)
            textField.constraint(.widthAnchor, constant: width)
            textField.constraint(.heightAnchor, constant: height)
            
            textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor.systemGray, .font: UIFont.systemFont(ofSize: 14, weight: .light)])
            
            textField.layer.borderWidth = 2
            textField.maxCount = characterLimit
            textField.borderStyle = .roundedRect
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
