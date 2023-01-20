//
//  ViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

final class ViewController: UIViewController {
    
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
        let label = UILabel.makeBasicLabel(labelText: "This is Text", textColor: .white, fontStyle: .headline, fontWeight: .bold)
        return label
    }()
    
    private let secondConsecutiveLabel = TwoHstackLabel.basicLabel(firstLabelText: "밴드 소개", firstTextColor: .white, firstFontStyle: .title2, firstFontWeight: .light, secondLabelText: "(선택)", secondTextColor: .white, secondFontStyle: .subheadline, secondFontWeight: .light)
    
    private let testTextView = UITextView.makeBasicTextView("우리 밴드를 더 잘 보여줄 수 있는 소개를 간단히 적어주세요", textColor: .white, lineSpacing: 5)
    
    private let titleLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: "밴드에 대해\n간단히 알려주세요", textColor: .white, fontStyle: .largeTitle, fontWeight: .heavy, numberOfLines: 2)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: "작성해주신 정보는 내 프로필로 만들어지고\n프로필은 다른 사용자들이 볼 수 있어요", textColor: .white, fontStyle: .title3, fontWeight: .regular, numberOfLines: 2)
        return label
    }()
    
    private lazy var firstVStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondConsecutiveLabel, firstTextField, checkLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var titleVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleVstack, firstVStack, testTextView])
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .systemGray
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        render()
        setNotificaiton()
        setConfiguration()
    }
    
    private func addSubviews() {
        view.addSubviews(mainScrollView)
        mainScrollView.addSubview(contentView)
    }
    
    private func render() {
        
        mainScrollView.constraint(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        
        mainScrollView.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        contentView.constraint(top: mainScrollView.topAnchor, leading: mainScrollView.leadingAnchor, bottom: mainScrollView.bottomAnchor, trailing: mainScrollView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        
        testTextView.constraint(.heightAnchor, constant: 200)
    }
    
    private func setNotificaiton() {
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemGray
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
                let isChecked = try await NetworkManager.shared.checkDuplication(with: firstTextField.text ?? "")
                
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
