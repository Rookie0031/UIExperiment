//
//  BandLeaderPositionSelectVC.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/27.
//

import UIKit

class BandLeaderPositionSelectVC: UIViewController {
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
    
    private let subTitleLabel = BasicLabel(contentText: "최대 2개까지 선택 가능합니다.",
                                           fontStyle: .content,
                                           textColorInfo: .gray02)
    
    private let collectionView = PositionCollectionView(
        entryPoint: .position,
        items: [.position(Position(
            instrumentName: "기타",
            instrumentImageName: .guitar, isETC: false)),
                .position(Position(instrumentName: "베이스", instrumentImageName: .bass, isETC: false)),
                .position(Position(instrumentName: "보컬", instrumentImageName: .vocal, isETC: false)),
                .position(Position(instrumentName: "드럼", instrumentImageName: .drum, isETC: false)),
                .position(Position(instrumentName: "기타", instrumentImageName: .guitar, isETC: false)),
                .position(Position(instrumentName: "케스터네츠", instrumentImageName: .etc, isETC: true))
    ])
    // MARK: Button 바꿔야함
    private let nextButton = BasicButton(text: "다음", widthPadding: 100, heightPadding: 20)
    
    private lazy var titleVstack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stepLabel, titleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        attribute()
    }
    
    private func setupLayout() {
        view.addSubview(titleVstack)
        titleVstack.constraint(top: view.safeAreaLayoutGuide.topAnchor,
                               leading: view.safeAreaLayoutGuide.leadingAnchor,
                               padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
        
        view.addSubview(nextButton)
        nextButton.constraint(bottom: view.safeAreaLayoutGuide.bottomAnchor, centerX: view.centerXAnchor)
        
        view.addSubview(collectionView)
        collectionView.constraint(top: titleVstack.bottomAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: nextButton.bottomAnchor,
                                  trailing: view.trailingAnchor,
                                  padding: UIEdgeInsets(top: 20, left: 16, bottom: 0, right: 16))
        collectionView.delegate = self
    }
    
    private func attribute() {
        view.backgroundColor = .gray01
    }
}

extension BandLeaderPositionSelectVC: PositionCollectionViewDelegate {
   func canSelectPosition(_ collectionView: UICollectionView, indexPath: IndexPath, selectedItemsCount: Int) -> Bool {
       return true
   }
}
