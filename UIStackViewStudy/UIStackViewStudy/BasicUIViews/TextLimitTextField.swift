//
//  BasicTextField.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/21.
//

import UIKit


enum CheckDuplicationCase {
    case userNickName
    case bandName
}

final class TextLimitTextField: UIView {
    
    
    private let placeholder: String
    
    private let maximumCount: Int

    private let duplicationCheckType: CheckDuplicationCase
    
    private lazy var textField: UITextField = {
        let textField = UITextField.makeBasicTextField(placeholder: placeholder, characterLimit: maximumCount)
        textField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
        return textField
    }()
    
    private let checkLabel: UIStackView = TwoHstackLabel.checkLabel
    
    private lazy var checkButton = {
        let button = BasicButton(text: "중복 확인", widthPadding: 24, heightPadding: 10)
        button.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        return button
    }()
    
    init(placeholer: String, maxCount: Int, checkCase: CheckDuplicationCase) {
        self.maximumCount = maxCount
        self.placeholder = placeholer
        self.duplicationCheckType = checkCase
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.constraint(.widthAnchor, constant: BasicComponentSize.width)
        self.constraint(.heightAnchor, constant: 55)
        
        addSubviews(textField, checkButton)
        textField.constraint(top: self.topAnchor, leading: self.leadingAnchor)
        
        checkButton.constraint(trailing: textField.trailingAnchor, centerY: textField.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10))
    }
}

extension TextLimitTextField {
    @objc func textFieldTextDidChange() {
        let maxCount = textField.maxCount
        if let text = textField.text {
            if text.count >= maxCount {
                let maxCountIndex = text.index(text.startIndex, offsetBy: maxCount)
                let fixedText = String(text[text.startIndex..<maxCountIndex])
                textField.text = fixedText + " "
                self.textField.text = fixedText
            }
        }
    }

    @objc func didTapCheckButton() {
        Task {
            do {
                let isChecked = try await DuplicationCheckRequest.checkDuplication(
                    checkCase: duplicationCheckType,
                    word: textField.text ?? "")
                showDuplicationCheckLabel(with: isChecked)
            } catch {
                print(error)
            }
        }
    }
    
    private func showDuplicationCheckLabel(with isChecked: Bool) {
        checkLabel.isHidden = false
        let imageView = checkLabel.arrangedSubviews.first! as! UIImageView
        imageView.image = isChecked ? UIImage(systemName: "checkmark.circle")! : UIImage(systemName: "x.circle")!
        imageView.tintColor = isChecked ? .systemBlue : .systemRed
        
        let label = checkLabel.arrangedSubviews.last! as! UILabel
        label.text = isChecked ? "가능합니다" : "불가능합니다"
        label.textColor = isChecked ? .systemBlue : .systemRed
    }
}
