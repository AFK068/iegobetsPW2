//
//  WrittenWishCell.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        static let wishLabelOffset: CGFloat = 8
        
        static let deleteButtonTextColor: UIColor = .black
        static let deleteButtonBackgroundColor: UIColor = .gray
        static let deleteButtonWidth: CGFloat = 50
        
        static let deleteButtonText: String = "Delete"
        static let deleteButtonTitleLabelFont: UIFont = .systemFont(ofSize: 14)
    }
    
    static let reuseId: String = "WrittenWishCell"
    
    // MARK: - Properties
    var deleteWish: (() -> Void)?
    
    // MARK: - UI Components
    private let stackView: UIStackView = UIStackView()
    private let deleteButton: UIButton = UIButton(type: .system)
    private let wishLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Methods
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    // MARK: -Private methods
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        let wrap: UIView = UIView()
        contentView.addSubview(wrap)
        wrap.pin(to: contentView, Constants.wishLabelOffset)
        
        stackView.addArrangedSubview(wishLabel)
        stackView.addArrangedSubview(deleteButton)
        
        
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        wrap.pinVertical(to: self, Constants.wrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.wrapOffsetH)
        
        stackView.axis = .vertical
        stackView.spacing = Constants.wishLabelOffset
        stackView.translatesAutoresizingMaskIntoConstraints = false
        wrap.addSubview(stackView)
        
        stackView.pinHorizontal(to: wrap, Constants.wishLabelOffset)
        stackView.pinVertical(to: wrap, Constants.wishLabelOffset)
        
        wishLabel.numberOfLines = 0
        
        deleteButton.setTitle(Constants.deleteButtonText, for: .normal)
        deleteButton.setTitleColor(Constants.deleteButtonTextColor, for: .normal)
        deleteButton.titleLabel?.font = Constants.deleteButtonTitleLabelFont
        deleteButton.backgroundColor = Constants.deleteButtonBackgroundColor
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.layer.cornerRadius = 5
    }
    
    // MARK: -objc
    @objc
    private func deleteButtonTapped() {
        deleteWish?()
    }
}
