//
//  AddWishCell.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        static let reuseId: String = "AddWishCell"
        static let titleButtonText: String = "Add wish"
        
        static let textViewBorderWidth: CGFloat = 1.0
        static let textViewCornerRadius: CGFloat = 5.0
        static let buttonCornerRadius: CGFloat = 5.0
        static let buttonHeight: CGFloat = 35.0
        static let textViewHeight: CGFloat = 40.0
        static let buttonWidth: CGFloat = 100.0
        static let verticalSpacing: CGFloat = 8.0
        static let buttonTopSpacing: CGFloat = 50.0
        static let horizontalPadding: CGFloat = 16.0
        
        static let buttonBackgroundColor: UIColor = .systemBlue
        static let textViewBorderColor: UIColor = .gray
        static let titleButtonTextColor: UIColor = .white
    }
    
    // MARK: - Properties
    var addWish: ((String) -> Void)?
    
    // MARK: - UI Components
    private let wishTextView = UITextView()
    private let button = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Private methods
    private func configureUI() {
        selectionStyle = .none
        configureTextView()
        configureButton()
    }
    
    private func configureTextView() {
        wishTextView.layer.borderWidth = Constants.textViewBorderWidth
        wishTextView.layer.borderColor = Constants.textViewBorderColor.cgColor
        wishTextView.layer.cornerRadius = Constants.textViewCornerRadius
        contentView.addSubview(wishTextView)
        
        wishTextView.pinLeft(to: contentView, Constants.horizontalPadding)
        wishTextView.pinRight(to: contentView, Constants.horizontalPadding)
        wishTextView.pinTop(to: contentView, Constants.verticalSpacing)
        wishTextView.setHeight(Constants.textViewHeight)
    }
    
    private func configureButton() {
        button.setTitle(Constants.titleButtonText, for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.setTitleColor(Constants.titleButtonTextColor, for: .normal)
        button.layer.cornerRadius = Constants.buttonCornerRadius
        button.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        contentView.addSubview(button)
        
        button.pinTop(to: wishTextView, Constants.buttonTopSpacing)
        button.pinCenterX(to: contentView)
        button.setHeight(Constants.buttonHeight)
        button.setWidth(Constants.buttonWidth)
        button.pinBottom(to: contentView, Constants.verticalSpacing)
    }
    
    // MARK: -objc
    @objc
    private func addWishButtonTapped() {
        let wish = wishTextView.text ?? ""
        let isNotEmpty = wish.rangeOfCharacter(from: .alphanumerics) != nil
        
        if isNotEmpty {
            addWish?(wish)
            wishTextView.text = ""
        }
    }
}
