//
//  AddBandMemberViewController.swift
//  UIStackViewStudy
//
//  Created by 장지수 on 2023/01/29.
//

import UIKit


enum TableViewSection: CaseIterable {
    case main
}

struct Person: Hashable {
    let name: String
    let id = UUID()
}

extension Person {
    static var data = [
        Person(name: "Philip"),
        Person(name: "Emma"),
        Person(name: "John"),
        Person(name: "Micle"),
        Person(name: "David"),
        Person(name: "Tom"),
    ]
}

class TableViewDataSource: UITableViewDiffableDataSource<TableViewSection, Person> {
    // DataSource 관련 프로토콜을 override할 예정
}

class AddBandMemberViewController: UIViewController {
    
    var people: [Person] = Person.data
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var dataSource: TableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // dataSource와 tableView 연결
        dataSource = TableViewDataSource(tableView: tableView) { (tableView, indexPath, person) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = person.name
            return cell
        }
        
        // apply를 사용해서 UI 업데이트
        var snapshot = dataSource.snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(people, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func setupLayout() {
        
    }
    
    private func attribute() {
        
    }
}

extension AddBandMemberViewController {
    func makeDataSource -> UITableViewDiffableDataSource<TableViewSection, Person> {
        return UITableViewDiffableDataSource<TableViewSection, Person>
    }
}
