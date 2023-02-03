////
////  AddPracticeSongTableVC.swift
////  UIStackViewStudy
////
////  Created by Jisu Jang on 2023/02/03.
////
//
//import UIKit
//
//final class AddPracticeSongTableVC: UIViewController {
//
//    private let mainTableView: UITableView = {
//        return $0
//    }(UITableView(frame: .zero))
//
//    private lazy var addPracticeSongButton = {
//        var configuration = UIButton.Configuration.filled()
//        var container = AttributeContainer()
//        container.font = UIFont.setFont(.contentBold)
//        configuration.baseBackgroundColor = .systemPurple
//        configuration.attributedTitle = AttributedString("합주곡 추가", attributes: container)
//        configuration.image = UIImage(systemName: "plus")
//        configuration.imagePadding = 10
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0)
//        let button = UIButton(configuration: configuration, primaryAction: nil)
//        button.addTarget(self, action: #selector(didTapAddPracticeSong), for: .touchUpInside)
//
//        return button
//    }()
//
//    private lazy var finalAddButton = {
//        var configuration = UIButton.Configuration.filled()
//        var container = AttributeContainer()
//        container.font = UIFont.setFont(.contentBold)
//        configuration.baseBackgroundColor = .systemBlue
//        configuration.attributedTitle = AttributedString("입력 완료", attributes: container)
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0)
//        let button = UIButton(configuration: configuration, primaryAction: nil)
//        button.addTarget(self, action: #selector(didTapAddPracticeSong), for: .touchUpInside)
//        return button
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupLayout()
//        attribute()
//    }
//
//    override func viewDidLayoutSubviews() {
//        applyButtonSnapshot()
//    }
//
//    private func attribute() {
//        self.view.backgroundColor = .dark01
//    }
//
//    private func setupLayout() {
//
//        addPracticeSongButton.constraint(top: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
//
//
//        finalAddButton.constraint(top: addPracticeSongButton.bottomAnchor,leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 40, left: 20, bottom: 10, right: 20))
//    }
//
//    private func applyButtonSnapshot() {
//        // StackView에 들어간 하위뷰들은 UIView 타입으로 인식합니다. 그래서 그 안에 cancleButton 프로퍼티에 접근하기 위해 map을 사용합니다.
//        if contentView.arrangedSubviews.count == 1 {
//            contentView.arrangedSubviews.map { $0 as! PracticeSongCardView }.forEach { $0.cancelButton.isHidden = true }
//        } else {
//            contentView.arrangedSubviews.map { $0 as! PracticeSongCardView }.forEach { $0.cancelButton.isHidden = false }
//        }
//    }
//}
//
//// ScrollView 가로 스크롤 막기
//extension AddPracticeSongViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//           if scrollView.contentOffset.x != 0 {
//               scrollView.contentOffset.x = 0
//           }
//       }
//}
//
//extension AddPracticeSongViewController {
//    @objc func didTapAddPracticeSong() {
//        let newCard = PracticeSongCardView(identifier: UUID().uuidString)
//        guard contentView.arrangedSubviews.count < 3 else { return }
//        contentView.insertArrangedSubview(newCard, at: contentView.arrangedSubviews.endIndex)
//        applyButtonSnapshot()
//    }
//
////    @objc func removeParticularCard(_ notificaiton: Notification) {
////        let cardID = notificaiton.object as? String
////        let removeView = contentView.arrangedSubviews.map({ $0 as! PracticeSongCardView }).first { $0.id == cardID }!
////        contentView.removeArrangedSubview(removeView)
////        if contentView.arrangedSubviews.count == 1 { hideCancelButton() }
////    }
//}
