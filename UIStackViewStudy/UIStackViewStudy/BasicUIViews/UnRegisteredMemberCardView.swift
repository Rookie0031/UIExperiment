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

    private let artistName = TwoHstackLabel.basicClassLabel(firstLabelText: "포지션", inputType: .required)

    private let artistNameTextField = BasicTextField(placeholder: "아티스트를 입력해주세요")

    private lazy var artistNameVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistName, artistNameTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    private let linkLabel = TwoHstackLabel.basicClassLabel(firstLabelText: "링크", inputType: .optional)

    private let linkDescription = BasicLabel(contentText: "* 우리밴드가 해당 곡을 합주한 작업물 링크를 입력해주세요", fontStyle: .content, textColorInfo: .gray02)

    private let linkTextField = BasicTextField(placeholder: "합주 영상이나 녹음파일 링크를 입력해주세요")

    private lazy var linkVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [linkLabel, linkDescription, linkTextField])
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
        self.addArrangedSubview(artistNameVstack)
        self.addArrangedSubview(linkVstack)
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

