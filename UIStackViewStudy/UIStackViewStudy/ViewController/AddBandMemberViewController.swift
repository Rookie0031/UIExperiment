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

struct CellInformation: Hashable {
    let id = UUID()
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
    
    var people: [CellInformation] = CellInformation.data
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var dataSource: UITableViewDiffableDataSource<TableViewSection, CellInformation> = self.makeDataSource()
    
    private let nextButton = BasicButton(text: "다음", widthPadding: 300, heightPadding: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(AddBandMemberTableViewCell.self, forCellReuseIdentifier: AddBandMemberTableViewCell.identifier)
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
        
        applySnapShot(with: people)
    }
    
    private func setupLayout() {
        
    }
    
    private func attribute() {
        
    }
    
    func applySnapShot(with items: [CellInformation]) {
        var snapShot = NSDiffableDataSourceSnapshot<TableViewSection, CellInformation>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension AddBandMemberViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<TableViewSection, CellInformation> {
        return UITableViewDiffableDataSource<TableViewSection, CellInformation>(tableView: self.tableView) { tableView, indexPath, person in
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddBandMemberTableViewCell.identifier, for: indexPath) as? AddBandMemberTableViewCell else { return UITableViewCell() }
            
            cell.configure(data: person)
            
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
      return headerView
    }
}

//MARK: Default Configuration
//let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//cell.backgroundColor = .dark01
//var content = cell.defaultContentConfiguration()
//content.image = UIImage(systemName: "star")
//content.text = person.nickName
//content.textProperties.font = UIFont.setFont(.headline01)
//content.textProperties.color = .white
//content.secondaryText = person.instrument
//content.secondaryTextProperties.font = UIFont.setFont(.content)
//content.secondaryTextProperties.color = .gray02
//cell.contentConfiguration = content
