//
//  AddBandMemberViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/29.
//

import UIKit


enum TableViewSection: String {
    case main
    
    var title: String {
        switch self {
        case .main: return "밴드 멤버 (3인)"
        }
    }
}

struct CellInformation: Hashable, Identifiable {
    let id = UUID().uuidString
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
    ]
}

final class TableViewDataSource: UITableViewDiffableDataSource<TableViewSection, CellInformation> {
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ddasd"
    }
}

final class AddBandMemberViewController: UIViewController {
    
    var people: [CellInformation] = []
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var dataSource: UITableViewDiffableDataSource<TableViewSection, CellInformation> = self.makeDataSource()
    
    private let nextButton = BasicButton(text: "다음", widthPadding: 300, heightPadding: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(AddBandMemberTableViewCell.self, forCellReuseIdentifier: AddBandMemberTableViewCell.classIdentifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.sectionHeaderHeight = 300
        tableView.backgroundColor = .dark01
        
        tableView.register(AddBandMemberTableHeaderView.self, forHeaderFooterViewReuseIdentifier: AddBandMemberTableHeaderView.classIdentifier)
        
        view.addSubview(tableView)
        tableView.constraint(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 16, bottom: 100, right: 16))
        
        view.backgroundColor = .dark01
        
        view.addSubview(nextButton)
        nextButton.constraint(leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 20))
        
        updateSnapShot(with: people)
    }
    
    private func setupLayout() {
        
    }
    
    private func attribute() {
        
    }
    
    func updateSnapShot(with items: [CellInformation]) {
        var snapShot = NSDiffableDataSourceSnapshot<TableViewSection, CellInformation>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension AddBandMemberViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<TableViewSection, CellInformation> {
        return UITableViewDiffableDataSource<TableViewSection, CellInformation>(tableView: self.tableView) { tableView, indexPath, person in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddBandMemberTableViewCell.classIdentifier, for: indexPath) as? AddBandMemberTableViewCell else { return UITableViewCell() }
            
            print("Function has been called")
            cell.delegate = self
            cell.configure(data: person)
            print("Configured Cell ID: \(person.id)")
            cell.selectionStyle = .none
            print("This is people Array")
            print(self.people)
            
            return cell
        }
    }
}

//MARK: TableView Delegate
extension AddBandMemberViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddBandMemberTableHeaderView.classIdentifier) as! AddBandMemberTableHeaderView
        let inviteMemberButtonAction = UIAction { _ in
            let nextViewController = UserSearchViewController()
            nextViewController.selectedUsers = []
            nextViewController.completion = { selectedUsers in
                print("completion Handelr 작동")
                self.people = selectedUsers
                self.updateSnapShot(with: self.people)
            }
            self.present(nextViewController, animated: true)
        }

        headerView.inviteMemberButton.addAction(inviteMemberButtonAction, for: .touchUpInside)
      return headerView
    }
}

extension AddBandMemberViewController: CellDeletable {
    func deleteCell(id: CellInformation.ID) {
        let index = self.people.cellIndex(with: id)
        print("This is index")
        print(index)
        //위에 있는 people과 여기있는 people이 다르다?? 왜 다르지??
        if self.people.count == 1 {
            print("Test Point")
            people.removeFirst()
        } else {
            self.people.remove(at: index)
        }
        updateSnapShot(with: people)
        print("This is poeple Array on Delete")
        print(self.people)
    }
}
// Array.Index is a type alias for Int
extension Array where Element == CellInformation {
    func cellIndex(with id: CellInformation.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else { return 0 }
        return index
    }
}
