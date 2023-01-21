//
//  BasicTextField.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/01/21.
//

import UIKit

final class BasicTextField: UIView {

    var placeholder: String

    //MARK: 여기 characterLimit을 조져야함
    lazy var textField: UITextField = UITextField.makeBasicTextField(placeholder: placeholder, characterLimit: 10000)

        //MARK: 중복 확인이 필요한 텍스트 필드인 경우 아래 로직대로 진행
        // 중복확인은 개별 텍스트 필드의 글자가 필요하니 일일이 이렇게 구현해주어야한다

    private lazy var checkLabel: UIStackView = TwoHstackLabel.checkLabel

    init(placeholder: String) {
        self.placeholder = placeholder
        super.init(frame: .zero)

        constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        constraint(.heightAnchor, constant: DeviceSize.width * 0.9 * 0.15)

        addSubview(textField)
        textField.constraint(top: self.topAnchor, leading: self.leadingAnchor)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
