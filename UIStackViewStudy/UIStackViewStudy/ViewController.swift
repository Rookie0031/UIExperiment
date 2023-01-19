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
        let textField = UITextField.makeBasicTextField(placeHolder: "밴드 이름을 입력해주세요", characterLimit: 5)
        
        let rightView = BasicRightView()
        rightView.testButton.addTarget(self, action: #selector(didTapCheckButton), for: .touchUpInside)
        textField.rightView = rightView
        textField.rightViewMode = .always
        return textField
    }()
    
    private lazy var checkLabel: UIStackView = CheckDuplicationLabel(isChecked: isChecked).text
    
    private let firstLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: "This is Text", textColor: .black, fontStyle: .headline, fontWeight: .bold)
        label.layoutMargins = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        return label
    }()
    
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
                
                if isChecked {
                    print("가능합니다")
                    checkLabel.isHidden = false
                } else {
                    print("불가능합니다")
                    checkLabel.isHidden = false
                    checkLabel.arrangedSubviews.last!.tintColor = .black
                }
                
            } catch {
                throw FetchError.unknown
            }
        }
    }
}
