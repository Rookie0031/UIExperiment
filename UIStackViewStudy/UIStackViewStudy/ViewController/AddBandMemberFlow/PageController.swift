//
//  PageController.swift
//  UIStackViewStudy
//
//  Created by Jisu Jang on 2023/02/03.
//

import UIKit

final class PageController: UIPageViewController {

    var images: [UIImage] = []

    var startingPageIndex: Int = 0

    var subViewControllers: [UIViewController] = []

    private lazy var dismissButton: UIButton = {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: CGFloat(24), weight: .light)
        $0.setImage(UIImage(systemName: "x.circle.fill", withConfiguration: imageConfiguration), for: .normal)
        $0.tintColor = .white
        $0.addTarget(self, action: #selector(didTapCustomBackButton), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        setSubViewController()
        setViewControllerFromIndex(index: startingPageIndex)
        setNavigationItem()
    }

    private func setNavigationItem() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: dismissButton)
        self.navigationItem.hidesBackButton = true
    }

    private func setSubViewController() {
        subViewControllers.append(BandLeaderPositionSelectVC())
        subViewControllers.append(AddBandMemberViewController())
    }

    private func setViewControllerFromIndex(index:Int) {
        self.setViewControllers([subViewControllers[index]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
}

// objc 함수
extension PageController {
    @objc func didTapCustomBackButton() {
        self.navigationController?.popViewController(animated: false)
    }
}

extension PageController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex <= 0 { return nil }
        return subViewControllers[currentIndex - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if currentIndex >= subViewControllers.count - 1 { return nil }
        return subViewControllers[currentIndex + 1]
    }
}

