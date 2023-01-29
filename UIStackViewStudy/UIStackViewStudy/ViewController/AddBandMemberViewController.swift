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
    lazy var dataSource: UITableViewDiffableDataSource<TableViewSection, Person> = self.makeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // dataSource와 tableView 연결
        applySnapShot(with: people)
    }
    
    private func setupLayout() {
        
    }
    
    private func attribute() {
        
    }
    
    func applySnapShot(with items: [Person]) {
        var snapShot = NSDiffableDataSourceSnapshot<TableViewSection, Person>()
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        self.dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension AddBandMemberViewController {
    func makeDataSource() -> UITableViewDiffableDataSource<TableViewSection, Person> {
        return UITableViewDiffableDataSource<TableViewSection, Person>(tableView: self.tableView) { tableView, indexPath, person in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = person.name
            return cell
        }
    }
}
