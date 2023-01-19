//
//  ViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

final class ViewController: UIViewController {
    
    private var isChecked = true
    
    private lazy var firstTextField: UITextField = {
        //MARK: 텍스트 필드 공통 컴퍼넌트 이용 - 플레이스홀더와 글자수 제한 입력
        let textField = UITextField.makeBasicTextField(placeHolder: "밴드 이름을 입력해주세요", characterLimit: 5)
        
        //MARK: 중복 확인이 필요한 텍스트 필드인 경우 아래 로직대로 진행
        // 중복확인은 개별 텍스트 필드의 글자가 필요하니 일일이 이렇게 구현해주어야한다
        let rightView = BasicRightView()
        rightView.testButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var checkLabel: UIStackView = TwoHstackLabel.checkLabel
    
    private let firstLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: "This is Text", textColor: .black, fontStyle: .headline, fontWeight: .bold)
        label.layoutMargins = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        return label
    }()
    
    private let secondConsecutiveLabel
    
    private lazy var firstVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstTextField, checkLabel, firstLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        render()
        setNotificaiton()
        setConfiguration()
    }
    
    private func addSubviews() {
        view.addSubviews(firstVStack)
    }
    
    private func render() {
        firstVStack.constraint(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    private func setNotificaiton() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func setConfiguration() {
        checkLabel.isHidden = true
    }
}

extension ViewController {
    @objc func textDidChange(noti: NSNotification) {
        let maxCount = firstTextField.maxCount
            if let text = firstTextField.text {
                if text.count >= maxCount {
                    let maxCountIndex = text.index(text.startIndex, offsetBy: maxCount)
                    let fixedText = String(text[text.startIndex..<maxCountIndex])
                    firstTextField.text = fixedText + " "
                    
                    let when = DispatchTime.now() + 0.01
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        self.firstTextField.text = fixedText
                    }
                }
            }
        }
    
    @objc func didTapCheckButton() {
        Task {
            do {
                isChecked = try await NetworkManager.shared.checkDuplication(with: firstTextField.text ?? "")
                
                showDuplicationCheckLabel()
                
            } catch {
                throw FetchError.unknown
            }
        }
    }
    
    private func showDuplicationCheckLabel() {
        checkLabel.isHidden = false
        let imageView = checkLabel.arrangedSubviews.first! as! UIImageView
        imageView.image = isChecked ? UIImage(systemName: "checkmark.circle")! : UIImage(systemName: "x.circle")!
        imageView.tintColor = isChecked ? .systemBlue : .systemRed
        let label = checkLabel.arrangedSubviews.last! as! UILabel
        label.text = isChecked ? "가능합니다" : "불가능합니다"
        label.textColor = isChecked ? .systemBlue : .systemRed
    }
}
