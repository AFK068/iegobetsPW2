//
//  WishMakerViewController.swift
//  iegobetsPW2
//
//  Created by Ivan on 30.10.2024.
//

import UIKit

// MARK: -Protocols
protocol WishMakerViewDelegate: AnyObject {
    func didPressAddWishButton()
    func didPressScheduleWishButton()
    func presentAlert(_ alert: UIAlertController)
}

final class WishMakerViewController: UIViewController, WishMakerViewDelegate {
    // MARK: - Constants
    private let wishMakerView = WishMakerView()
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        wishMakerView.delegate = self
        updateView(to: wishMakerView)
    }
    
    // MARK: -Methods
    func didPressAddWishButton() {
        let wishStoringVC = WishStoringViewController()
        present(wishStoringVC, animated: true, completion: nil)
    }
    
    func presentAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
    
    func didPressScheduleWishButton() {
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    // MARK: -Private methods
    private func updateView(to otherView: UIView) {
        view.addSubview(otherView)
        otherView.pin(to: view)
    }
}
