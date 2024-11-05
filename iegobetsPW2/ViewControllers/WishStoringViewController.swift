//
//  WishStoringViewController.swift
//  iegobetsPW2
//
//  Created by Ivan on 02.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    // MARK: - Constants
    private let wishTableView = WishTableView()
    private let defaults = UserDefaults.standard
    private let wishesKey = "wishesKey"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWishes()
        setupWishTableView()
    }
    
    // MARK: - Private methods
    private func setupWishTableView() {
        view.addSubview(wishTableView)
        wishTableView.pin(to: view)
        wishTableView.getTable().dataSource = self
        wishTableView.getTable().register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        wishTableView.getTable().register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.Constants.reuseId)
    }
    
    private func loadWishes() {
        if let storedWishes = defaults.array(forKey: wishesKey) as? [String] {
            for wish in storedWishes {
                wishTableView.addWish(wish)
            }
        }
    }
    
    private func saveWishes() {
        let wishesToSave = wishTableView.getWishArray()
        defaults.set(wishesToSave, forKey: wishesKey)
    }
}

// MARK: - Extensions
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return wishTableView.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return wishTableView.getWishArray().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath ) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.Constants.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] wish in
                self?.wishTableView.addWish(wish)
                self?.saveWishes()
                tableView.reloadData()
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            let wish = wishTableView.getWishArray()[indexPath.row]
            cell.configure(with: wish)
            
            cell.deleteWish = { [weak self] in
                self?.wishTableView.removeWish(at: indexPath.row)
                self?.saveWishes()
                tableView.reloadData()
            }
            
            return cell
        }
    }
}
