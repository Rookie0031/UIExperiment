//
//  AlertListViewController.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/02/05.
//

import UIKit

final class AlertListViewControlelr: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }

    private func attribute() {
        self.tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: AlertTableViewCell.classIdentifier)

        self.tableView.backgroundColor = .dark01
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.classIdentifier, for: indexPath) as? AlertTableViewCell else { return UITableViewCell() }

        cell.configure(titleLable: "테스트", subtitleLabel: "테스트 섭라벨", uploadTime: "2022 02 03", isInvitation: false)
        cell.backgroundColor = .dark01

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
