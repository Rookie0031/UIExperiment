//
//  BandLeaderPositionSelectVC.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/27.
//

import UIKit

class BandLeaderPositionSelectVC: UIViewController {
    //entrypOint position 테스트코드
    
    private lazy var collectionView = {
        let collectionView = PositionCollectionView(
            entryPoint: .position,
            items: [.position(Position(
                instrumentName: "기타",
                instrumentImageName: .guitar, isETC: false)),
                    .position(Position(instrumentName: "베이스", instrumentImageName: .bass, isETC: false)),
                    .position(Position(instrumentName: "보컬", instrumentImageName: .vocal, isETC: false)),
                    .position(Position(instrumentName: "드럼", instrumentImageName: .drum, isETC: false)),
                    .position(Position(instrumentName: "기타", instrumentImageName: .guitar, isETC: false)),
                    .position(Position(instrumentName: "케스터네츠", instrumentImageName: .etc, isETC: true)),
                    .position(Position(instrumentName: "케스터네츠", instrumentImageName: .etc, isETC: true)),
                    .position(Position(instrumentName: "케스터네츠", instrumentImageName: .etc, isETC: true)),
        ])
        collectionView.collectionView.register(BandLeaderPositionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "BandLeaderPositionHeaderView")
        collectionView.collectionView.delegate = self
        return collectionView
    }()
    // MARK: Button 바꿔야함
    private let nextButton = BasicButton(text: "다음", widthPadding: 300, heightPadding: 20)
    
    private var contentView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.setContentHuggingPriority(.defaultLow, for: .vertical)
        return view
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        attribute()
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        collectionView.constraint(to: self.view)
    }
    
    private func attribute() {
        view.backgroundColor = .dark01
    }
}

extension BandLeaderPositionSelectVC: PositionCollectionViewDelegate {
   func canSelectPosition(_ collectionView: UICollectionView, indexPath: IndexPath, selectedItemsCount: Int) -> Bool {
       return true
   }
}

extension BandLeaderPositionSelectVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "BandLeaderPositionHeaderView", for: indexPath) as! BandLeaderPositionHeaderView
        return headerView
    }
}

extension BandLeaderPositionSelectVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}

extension BandLeaderPositionSelectVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if scrollView.contentOffset.x != 0 {
               scrollView.contentOffset.x = 0
           }
       }
}
