//
//  AddBandMemberViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/29.
//

import UIKit

final class AddBandMemberViewController: UIViewController {

    //TODO: 유저 정보로 데이터 타입을 바꿔야함
    var people: [CellInformation] = []

    //MARK: - View
    private lazy var tableView: UITableView = {
        $0.register(AddBandMemberTableViewCell.self,
                    forCellReuseIdentifier: AddBandMemberTableViewCell.classIdentifier)
        $0.register(AddBandMemberTableHeaderView.self,
                    forHeaderFooterViewReuseIdentifier: AddBandMemberTableHeaderView.classIdentifier)
        $0.sectionHeaderHeight = 300
        $0.backgroundColor = .dark01
        $0.delegate = self
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    lazy var dataSource: UITableViewDiffableDataSource<TableViewSection, CellInformation> = self.makeDataSource()

    //TODO: 밴드 리더 포지션 선택뷰의 버튼으로 바꿔야함
    private let nextButton = BasicButton(text: "다음", widthPadding: 300, heightPadding: 20)

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        setupLayout()
        updateSnapShot(with: people)
    }

    //MARK: - Method
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 100, right: 16))

        view.addSubview(nextButton)
        nextButton.constraint(leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 20))
    }
    
    private func attribute() {
        view.backgroundColor = .dark01
    }
}

//MARK: DiffableDataSource 관련 메소드
extension AddBandMemberViewController {

    func updateSnapShot(with items: [CellInformation]) {
        var snapShot = NSDiffableDataSourceSnapshot<TableViewSection, CellInformation>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }

    func makeDataSource() -> UITableViewDiffableDataSource<TableViewSection, CellInformation> {
        return UITableViewDiffableDataSource<TableViewSection, CellInformation>(tableView: self.tableView) { tableView, indexPath, person in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddBandMemberTableViewCell.classIdentifier, for: indexPath) as? AddBandMemberTableViewCell else { return UITableViewCell() }
            print("Person print")
            print(person)
            cell.configure(data: person)
            
            let deleteAction = UIAction { _ in
                self.people.removeAll { $0.id == cell.id }
                self.updateSnapShot(with: self.people)
            }
            
            cell.deleteButton.addAction(deleteAction, for: .touchUpInside)
            cell.selectionStyle = .none
            print(self.people)
            
            return cell
        }
    }
}

extension AddBandMemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddBandMemberTableHeaderView.classIdentifier) as! AddBandMemberTableHeaderView
        //MARK: 회원 검색 뷰로 이동
        let inviteMemberButtonAction = UIAction { _ in
            let nextViewController = UserSearchViewController()
            nextViewController.completion = { selectedUsers in
                for data in selectedUsers {
                    if self.people.contains(where: { $0.id == data.id }) == false {
                        self.people.append(data)
                    }
                }
                self.updateSnapShot(with: self.people)
            }
            self.present(nextViewController, animated: true)
        }

        headerView.inviteMemberButton.addAction(inviteMemberButtonAction, for: .touchUpInside)

        let unRegisteredMemberButtonAction = UIAction { _ in
            let nextVC = AddUnRegisteredMemberViewController()
            nextVC.completion = { addedMembers in
                self.people = self.people + addedMembers
                self.updateSnapShot(with: self.people)
            }
            self.present(nextVC, animated: true)
        }

        headerView.inviteUnRegisteredMemberButton.addAction(unRegisteredMemberButtonAction, for: .touchUpInside)
      return headerView
    }
}

enum TableViewSection: String {
    case main

    var title: String {
        switch self {
        case .main: return "밴드 멤버 (3인)"
        }
    }
}

struct CellInformation: Hashable, Identifiable {
    var id = UUID().uuidString
    let nickName: String
    let instrument: String
}

extension CellInformation {
    static var data = [
        CellInformation(nickName: "구엘", instrument: "드럼"),
        CellInformation(nickName: "루키", instrument: "베이스"),
        CellInformation(nickName: "노엘", instrument: "기타"),
        CellInformation(nickName: "데이크", instrument: "보컬"),
        CellInformation(nickName: "알로라", instrument: "신디사이저"),
        CellInformation(nickName: "가즈윌", instrument: "바이올린"),
        CellInformation(nickName: "쏘시지불나방전기뱀장어", instrument: "바이올린")
    ]
}

//MARK: Identifier에 따른 정수형 index 추출 extension
//extension Array where Element == CellInformation {
//    func cellIndex(with id: CellInformation.ID) -> Self.Index {
//        guard let index = firstIndex(where: { $0.id == id }) else { return 0 }
//        return index
//    }
//}
