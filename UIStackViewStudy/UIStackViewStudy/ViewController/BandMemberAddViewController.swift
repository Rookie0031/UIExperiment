//
//  BandMemmberAddViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/27.
//


import UIKit

class BandMemberAddViewController: UIViewController {
    //entrypOint position 테스트코드
    
    // MARK: 이 뷰를 업로드할 때, 서버에 UID를 날리고 그 UID에 해당하는 닉네임을 업데이트해야함
    private let stepLabel = BasicLabel(contentText: "1/3", fontStyle: .caption, textColorInfo: .gray02)
    
    private let titleLabel = {
        let label = BasicLabel(contentText: "루키님의\n밴드에서 포지션을\n알려주세요",
                               fontStyle: .largeTitle01,
                               textColorInfo: .white)
        label.numberOfLines = 3
        return label
    }()
    
    private let subTitleLabel = {
        let label = BasicLabel(contentText: "처음 선택한 악기가\n나의 Main 포지션이 됩니다",
                               fontStyle: .largeTitle01,
                               textColorInfo: .white)
        label.textColor = .systemRed
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var titleVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stepLabel, titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: Button 바꿔야함
    private let nextButton = BasicButton(text: "다음", widthPadding: 300, heightPadding: 20)
    
    private lazy var contentView = UIView(frame: .zero)
    
    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .dark01
//        scrollView.delegate = self
        return scrollView
    }()
    
    
    override func loadView() {
        view = mainScrollView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        attribute()
    }
    
    private func setupLayout() {
        
        mainScrollView.addSubview(contentView)
        contentView.constraint(top: mainScrollView.contentLayoutGuide.topAnchor, leading: mainScrollView.contentLayoutGuide.leadingAnchor, bottom: mainScrollView.contentLayoutGuide.bottomAnchor, trailing: mainScrollView.contentLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 160, right: 20))
        
        view.addSubview(titleVstack)
        titleVstack.constraint(top: contentView.topAnchor,
                               leading: contentView.leadingAnchor,
                               padding: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0))
        
        view.addSubview(nextButton)
        nextButton.constraint(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor)
    }
    
    private func attribute() {
        view.backgroundColor = .dark01
    }
}

