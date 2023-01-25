//
//  ViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/18.
//

import UIKit

final class AddPracticeSongViewController: UIViewController {
    
    private var practiceSongs: [PracticeSongCardView] = [PracticeSongCardView()]

    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: practiceSongs)
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        return stackView
    }()

    private lazy var mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.backgroundColor = .dark01
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var addPracticeSongButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.setFont(.contentBold)
        configuration.baseBackgroundColor = .systemPurple
        configuration.attributedTitle = AttributedString("합주곡 추가", attributes: container)
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(didTapAddPracticeSong), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var finalAddButton = {
        let button = UIButton()
        button.setTitle("입력 완료", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapAddPracticeSong), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        attribute()
    }

    private func attribute() {
        self.view.backgroundColor = .dark01
    }

    private func setupLayout() {
        
        view.addSubview(mainScrollView)
        
        mainScrollView.constraint(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        mainScrollView.addSubview(contentView)
        
        contentView.constraint(top: mainScrollView.contentLayoutGuide.topAnchor, leading: mainScrollView.contentLayoutGuide.leadingAnchor, bottom: mainScrollView.contentLayoutGuide.bottomAnchor, trailing: mainScrollView.contentLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 10, bottom: 160, right: 20))
        
        mainScrollView.addSubview(addPracticeSongButton)
        
        addPracticeSongButton.constraint(top: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
        
        view.addSubview(finalAddButton)
        finalAddButton.constraint(leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20))
    }
}

// ScrollView 가로 스크롤 막기
extension AddPracticeSongViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if scrollView.contentOffset.x != 0 {
               scrollView.contentOffset.x = 0
           }
       }
}

extension AddPracticeSongViewController {
    @objc func didTapAddPracticeSong() {
        print("new card 추가")
        let newCard = PracticeSongCardView()
        contentView.insertArrangedSubview(newCard, at: 0)
    }
}
