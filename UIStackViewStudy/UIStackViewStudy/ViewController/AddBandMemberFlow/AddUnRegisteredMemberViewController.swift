//
//  AddUnRegisteredMember.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/02/03.
//

import UIKit

final class AddUnRegisteredMemberViewController: UIViewController {

    var addedMembers: [CellInformation] = []

    var completion: (_ registeredMember: [CellInformation]) -> Void = { addedMembers in }

    lazy var firstData = CellInformation(nickName: firstPracticeSongCard.bandMemberNameTextField.textField.text ?? "", instrument: firstPracticeSongCard.otherPositionTextField.textField.text ?? "")

    lazy var firstPracticeSongCard: UnRegisteredMemberCardView = {
        let card = UnRegisteredMemberCardView()
        let action = UIAction { _ in
            card.removeFromSuperview()
            self.addedMembers.append(self.firstData)
            self.addedMembers.removeAll { $0.id == self.firstData.id }
        }
        card.cancelButton.addAction(action, for: .touchUpInside)
        return card
    }()

    private lazy var contentView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstPracticeSongCard])
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
        configuration.attributedTitle = AttributedString("멤버 추가", attributes: container)
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 10
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0)
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.addTarget(self, action: #selector(didTapAddPracticeSong), for: .touchUpInside)

        return button
    }()

    private lazy var finalAddButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont.setFont(.contentBold)
        configuration.baseBackgroundColor = .systemBlue
        configuration.attributedTitle = AttributedString("추가 완료", attributes: container)
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
        let button = UIButton(configuration: configuration, primaryAction: finalAction)
        return button
    }()

    private lazy var finalAction = UIAction { _ in
        for subview in self.contentView.arrangedSubviews {
            let card = subview as! UnRegisteredMemberCardView
            let data = CellInformation(nickName: card.bandMemberNameTextField.textField.text ?? "", instrument: card.otherPositionTextField.textField.text ?? "")
            self.addedMembers.append(data)
        }
        self.dismiss(animated: true){
            self.completion(self.addedMembers)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        attribute()
    }

    override func viewDidLayoutSubviews() {
        applyButtonSnapshot()
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

        mainScrollView.addSubview(finalAddButton)

        finalAddButton.constraint(top: addPracticeSongButton.bottomAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 20, bottom: 10, right: 20))
    }

    private func applyButtonSnapshot() {
        // StackView에 들어간 하위뷰들은 UIView 타입으로 인식합니다. 그래서 그 안에 cancleButton 프로퍼티에 접근하기 위해 map을 사용합니다.
        if contentView.arrangedSubviews.count == 1 {
            contentView.arrangedSubviews.map { $0 as! UnRegisteredMemberCardView }.forEach { $0.cancelButton.isHidden = true }
        } else {
            contentView.arrangedSubviews.map { $0 as! UnRegisteredMemberCardView }.forEach { $0.cancelButton.isHidden = false }
        }
    }
}

// ScrollView 가로 스크롤 막기
extension AddUnRegisteredMemberViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           if scrollView.contentOffset.x != 0 {
               scrollView.contentOffset.x = 0
           }
       }
}

extension AddUnRegisteredMemberViewController {
    @objc func didTapAddPracticeSong() {
        let newCard = UnRegisteredMemberCardView()
        guard contentView.arrangedSubviews.count < 3 else { return }
        // UI에 카드뷰 추가 (stackView에 넣는 방식임)
        contentView.insertArrangedSubview(newCard, at: contentView.arrangedSubviews.endIndex)

//        // 전달하려는 배열에 데이터 추가
//        let data = CellInformation(nickName: newCard.bandMemberNameTextField.textField.text ?? "", instrument: newCard.otherPositionTextField.textField.text ?? "")
//
//        let action = UIAction { _ in
//            newCard.removeFromSuperview()
//            self.addedMembers.removeAll { $0.id == data.id }
//        }
//        newCard.cancelButton.addAction(action, for: .touchUpInside)
//
//        addedMembers.append(data)
        applyButtonSnapshot()
    }
}

