//
//  WishStoringView.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.11.2024.
//

import UIKit

class WishTableView: UIView {
    // MARK: - Constants
    enum Constants {
        static let tableCornerRadius: Double = 20
        static let tableOffset: Double = 10
        static let numberOfSections = 2
        
        static let tableBackgroundColor: UIColor = .gray
    }
    
    // MARK: - UI Components
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [String] = []
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUi()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func getNumberOfSections() -> Int {
        return Constants.numberOfSections
    }
    
    func removeWish(at index: Int) {
        wishArray.remove(at: index)
    }
    
    func addWish(_ wish: String) {
        wishArray.append(wish)
    }
    
    func getTable() -> UITableView {
        return table
    }
    
    func getWishArray() -> [String] {
        return wishArray
    }
    
    // MARK: - Private methods
    private func configureUi() {
        configureTable()
    }
    
    private func configureTable() {
        self.addSubview(table)
        table.backgroundColor = Constants.tableBackgroundColor
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: self, Constants.tableOffset)
    }
}
