//
//  BasicTextField.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/21.
//

import UIKit

final class BasicTextField: UIView {
    
    var maximumCount: Int
    
    //MARK: 여기 characterLimit을 조져야함 
    lazy var textField: UITextField = UITextField.makeBasicTextField(placeholder: "밴드 이름을 입력해주세요", characterLimit: maximumCount)
    
        //MARK: 중복 확인이 필요한 텍스트 필드인 경우 아래 로직대로 진행
        // 중복확인은 개별 텍스트 필드의 글자가 필요하니 일일이 이렇게 구현해주어야한다
    
    private lazy var checkLabel: UIStackView = TwoHstackLabel.checkLabel
    
    init(maxCount: Int) {
        self.maximumCount = maxCount
        super.init(frame: .zero)
        let rightView = BasicRightView()
        rightView.testButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        
        constraint(.widthAnchor, constant: DeviceSize.width * 0.9)
        constraint(.heightAnchor, constant: DeviceSize.width * 0.9 * 0.15)
        
        addSubview(textField)
        textField.constraint(top: self.topAnchor, leading: self.leadingAnchor)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BasicTextField {
    @objc func textFieldTextDidChange(noti: NSNotification) {
        print("text Field Text change")
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
