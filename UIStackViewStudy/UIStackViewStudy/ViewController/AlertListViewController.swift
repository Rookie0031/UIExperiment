//
//  AlertListViewController.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/02/05.
//

import UIKit

final class AlertListViewControlelr: UITableViewController {

    private var alertListData: [AlertList] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        fetchAlertListData()
    }

    private func attribute() {
        self.tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: AlertTableViewCell.classIdentifier)

        self.tableView.backgroundColor = .dark01
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlertTableViewCell.classIdentifier, for: indexPath) as? AlertTableViewCell else { return UITableViewCell() }
        cell.configure(titleLable: alertListData[indexPath.row].content, subtitleLabel: alertListData[indexPath.row].content, uploadTime: alertListData[indexPath.row].updatedDate, isInvitation: alertListData[indexPath.row].isInvitation)

        cell.backgroundColor = .dark01

        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.alertListData.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if alertListData[indexPath.row].isInvitation == true {
            return 150
        }

//        var indexPathList: [Int] = []
//        for (index, data) in alertListData.enumerated() {
//            if data.isInvitation == true {
//                indexPathList.append(index)
//            }
//        }
        return 100
    }
}

extension AlertListViewControlelr {
    //MARK: 추후 테스트 API는 삭제하고 다른 API로 대체해야함
    private func fetchAlertListData() {
        Task {
            do {
                guard let url = URL(string: "http://43.201.55.66:8080/alerts/test") else { throw NetworkError.badURL }

                let (data, response) = try await URLSession.shared.data(from: url)
                let httpResponse = response as! HTTPURLResponse

                if (200..<300).contains(httpResponse.statusCode) {
                    let decodedData = try JSONDecoder().decode(AlertListDTO.self, from: data)
                    self.alertListData = decodedData.alertList
                } else {
                    throw NetworkError.failedRequest(status: httpResponse.statusCode)
                }
            } catch {
                print(error)
            }
            self.tableView.reloadData()
        }
    }

    private func rejectInvitation(_ error: Error) {
        // Comment를 이용해서 localization할 때 각국언어로 바꿀 수 있다고함
        // 애플 공식 app tutorial에 나오길래 한번써봄
        let alertTitle = NSLocalizedString("초대 거절", comment: "Invitation reject title")
        let alertMessage = NSLocalizedString("밴드 ‘로젤리아’의 초대를 거절하시겠습니까?", comment: "Invitation reject message")
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("확인", comment: "Alert OK button title")
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { [weak self] _ in
            self?.dismiss(animated: true)
        }))
        present(alert, animated: true, completion: nil)
    }
}
