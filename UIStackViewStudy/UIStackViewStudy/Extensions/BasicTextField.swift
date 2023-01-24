//
//  BasicTextField.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/01/21.
//

import UIKit

final class BasicTextField: UIView {

    var placeholder: String

    lazy var textField: UITextField = UITextField.makeBasicTextField(placeholder: placeholder)

    init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        setupLayout()
        
    }
    
    private func setupLayout() {
        self.constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        self.constraint(.heightAnchor, constant: 55)

        self.addSubview(textField)
        textField.constraint(leading: self.leadingAnchor, centerY: self.centerYAnchor)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// 텍스트 필드 맨앞의 패딩 효과를 주기위한 빈 UIView
class EmptyView: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        constraint(.widthAnchor, constant: 20)
        constraint(.heightAnchor, constant: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
