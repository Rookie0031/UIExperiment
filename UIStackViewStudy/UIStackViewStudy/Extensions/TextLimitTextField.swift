//
//  BasicTextField.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/21.
//

import UIKit

final class TextLimitTextField: UIView {

    private let placeholder: String
    private let maximumCount: Int

    private lazy var textField: UITextField = UITextField.makeBasicTextField(placeholder: placeholder, characterLimit: maximumCount)
    
    private let checkLabel: UIStackView = TwoHstackLabel.checkLabel

    private lazy var checkButton = {
        let button = DuplicationCheckButton()
        button.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        return button
    }()
    
    init(placeholer: String, maxCount: Int) {
        self.maximumCount = maxCount
        self.placeholder = placeholer
        super.init(frame: .zero)
        
        setupLayout()
        
        // 텍스트 필드 글자수 제한을 위한 observer추가
        textField.addTarget(self, action: #selector(textFieldTextDidChange), for: .editingChanged)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
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
                    
                    let when = DispatchTime.now() + 0.01
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.textField.text = fixedText
                    }
                }
            }
        }
    
    @objc func didTapCheckButton() {
        Task {
            do {
                let isChecked = try await NetworkManager.shared.checkDuplication(with: textField.text ?? "")
                
                showDuplicationCheckLabel(with: isChecked)
                
            } catch {
                throw FetchError.unknown
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

class DuplicationCheckButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setTitle("중복 확인", for: .normal)
        titleLabel?.font = UIFont.setFont(.contentBold)
        backgroundColor = .systemPurple
        layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 중복 확인 버튼의 패딩값 조절
    override var intrinsicContentSize: CGSize {
        get {
            let baseSize = super.intrinsicContentSize
            return CGSize(width: baseSize.width + 24, height: baseSize.height + 10)
        }
    }
}
