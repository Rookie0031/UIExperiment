//
//  PracticeSongCardView.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/02/03.
//
import UIKit

final class UnRegisteredMemberCardView: UIStackView, Identifiable {

    let id: String

    lazy var cancelButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        let action = UIAction { _ in
            self.removeFromSuperview()
            print("class Identifier \(self.id)")
            NotificationCenter.default.post(name: Notification.Name("UnRegisteredMemberCardView"), object: self.id)
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private let bandMemberName = TwoHstackLabel.basicClassLabel(firstLabelText: "닉네임", inputType: .required)

    private let practiceSongTextField = BasicTextField(placeholder: "합주곡 제목을 입력해주세요")

    private lazy var practiceSongNameVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [bandMemberName, practiceSongTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let positionLabel = TwoHstackLabel.basicClassLabel(firstLabelText: "포지션", inputType: .required)

    private var positionSelect: SelectCollectionView = {
        $0.constraint(.heightAnchor, constant: 110)
        return $0
    }(SelectCollectionView(widthState: .fixed, items: ["보컬", "기타", "베이스", "드럼", "키보드"], widthSize: 100, itemSpacing: 7))

    private lazy var positionSelectVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [positionLabel, positionSelect])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let otherPosition = TwoHstackLabel.basicClassLabel(firstLabelText: "그 외 포지션", inputType: .optional)

    private let positionDescription = BasicLabel(contentText: "* 그 외 포지션은 공백 포함 10자 이하로 입력가능합니다.", fontStyle: .content, textColorInfo: .gray02)

    private let otherPositionTextField = BasicTextField(placeholder: "그 외 포지션을 입력해주세요.")

    private lazy var otherPositionVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [otherPosition, positionDescription, otherPositionTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    init(identifier: String) {
        self.id = identifier
        super.init(frame: .zero)
        setupLayout()
        attribute()
    }

    private func setupLayout() {
        self.addArrangedSubview(practiceSongNameVstack)
        self.addArrangedSubview(positionSelectVstack)
        self.addArrangedSubview(otherPositionVstack)
        self.axis = .vertical
        self.spacing = 40
        self.layoutMargins = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
        self.isLayoutMarginsRelativeArrangement = true

        self.addSubview(cancelButton)
        cancelButton.constraint(top: self.topAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10))
    }

    private func attribute() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .dark02
        cancelButton.isHidden = true
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

