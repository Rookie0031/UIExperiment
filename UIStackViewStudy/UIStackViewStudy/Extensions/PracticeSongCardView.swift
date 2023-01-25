//
//  PracticeSongCardView.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/25.
//
import UIKit

class PracticeSongCardView: UIStackView {
    
    private let practiceSongName = TwoHstackLabel.basicClassLabel(firstLabelText: "합주곡 제목", inputType: .required)
    
    private let practiceSongTextField = BasicTextField(placeholder: "합주곡 제목을 입력해주세요")
    
    private lazy var practiceSongNameVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [practiceSongName, practiceSongTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    private let artistName = TwoHstackLabel.basicClassLabel(firstLabelText: "아티스트", inputType: .required)
    
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
    
    
    override init(frame: CGRect) {
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
    }
    
    private func attribute() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .dark02
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
