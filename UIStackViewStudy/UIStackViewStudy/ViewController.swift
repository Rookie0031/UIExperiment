//
//  ViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

final class ViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: "밴드에 대해\n간단히 알려주세요", textColor: .white, fontStyle: .largeTitle, fontWeight: .heavy, numberOfLines: 2)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel.makeBasicLabel(labelText: "작성해주신 정보는 내 프로필로 만들어지고\n프로필은 다른 사용자들이 볼 수 있어요", textColor: .white, fontStyle: .title3, fontWeight: .regular, numberOfLines: 2)
        return label
    }()
    
    private let bandNameLabel = TwoHstackLabel.basicLabel(firstLabelText: "밴드 이름", firstTextColor: .white, firstFontStyle: .title2, firstFontWeight: .light, secondLabelText: "(선택)", secondTextColor: .white, secondFontStyle: .subheadline, secondFontWeight: .light)
    
    private let bandIntroductionLabel = TwoHstackLabel.basicLabel(firstLabelText: "밴드 소개", firstTextColor: .white, firstFontStyle: .title2, firstFontWeight: .light, secondLabelText: "(선택)", secondTextColor: .white, secondFontStyle: .subheadline, secondFontWeight: .light)
    
    private lazy var bandNamingTextFieldView: UIView = {
        let textField = BasicTextField(maxCount: 10)
        return textField
    }()
    
    private lazy var testTextField: UIView = {
        let textField = BasicTextField(maxCount: 20)
        return textField
    }()
    
    private lazy var checkLabel: UIStackView = TwoHstackLabel.checkLabel
    
    private let bandIntroTextView = {
        BasicTextView.maxCount = 30
        let textView = BasicTextView()
        return textView
    }()
    
    private lazy var titleVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var textFieldVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bandNameLabel, bandNamingTextFieldView, checkLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var textViewVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bandIntroductionLabel, bandIntroTextView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [testTextField, titleVstack, textFieldVstack, textViewVstack])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
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
        setConfiguration()
    }
    
    private func addSubviews() {
        view.addSubviews(mainScrollView)
        mainScrollView.addSubview(contentView)
    }
    
    private func render() {
        
        titleVstack.constraint(leading: view.safeAreaLayoutGuide.leadingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
        
        mainScrollView.constraint(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
        
        mainScrollView.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        contentView.constraint(top: mainScrollView.topAnchor, leading: mainScrollView.leadingAnchor, bottom: mainScrollView.bottomAnchor, trailing: mainScrollView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    private func setConfiguration() {
        view.backgroundColor = .systemGray
        checkLabel.isHidden = true
    }
}

extension ViewController {
    
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
