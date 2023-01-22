//
//  BasicTextField.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/01/21.
//

import UIKit

final class BasicTextField: UIView {

    var placeholder: String

    lazy var textField: UITextField = UITextField.makeBasicTextField(placeholder: placeholder, characterLimit: 10000)

    init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)

        constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        constraint(.heightAnchor, constant: DeviceSize.width * 0.9 * 0.15)

        addSubview(textField)
        textField.constraint(leading: self.leadingAnchor, centerY: self.centerYAnchor)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
