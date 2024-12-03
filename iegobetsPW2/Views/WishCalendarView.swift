//
//  WishCalendarView.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import UIKit

final class WishCalendarView: UIView {
    // MARK: - Constants
    enum Constants {
        static let contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        static let buttonFontSize: CGFloat = 40
        static let buttonHeight: CGFloat = 40
        static let buttonWidth: CGFloat = 40
        static let buttonTopPadding: CGFloat = 20
        static let collectionTopPadding: CGFloat = 20
        static let collectionBottomPadding: CGFloat = 20

        static let addButtonTitle = "+"
        static let collectionBackgroundColor = UIColor.white
        static let buttonBackgroundColor = UIColor.black
    }
    
    // MARK: - UI Components
    private var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    var addEventButton: UIButton = UIButton(type: .system)
    
    // MARK: - Delegates
    weak var delegate: WishCalendarViewControllerDelegate?
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Methods
    func getCollectionView() -> UICollectionView {
        return collectionView
    }
    
    func updateEvents(_ events: [CalendarEventModel]) {
        
        collectionView.reloadData()
    }
    
    // MARK: - Private methods
    private func configureUI() {
        configureCollection()
        configureAddEventButton()
    }
    
    private func configureCollection() {
        addSubview(collectionView)
        
        collectionView.backgroundColor = Constants.collectionBackgroundColor
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)

        collectionView.pinHorizontal(to: self)
        collectionView.pinTop(to: self.safeAreaLayoutGuide.topAnchor, Constants.collectionTopPadding)
        collectionView.pinBottom(to: self.safeAreaLayoutGuide.bottomAnchor, Constants.collectionBottomPadding)
    }
    
    private func configureAddEventButton() {
        addSubview(addEventButton)
        
        addEventButton.setTitle(Constants.addButtonTitle, for: .normal)
        addEventButton.titleLabel?.font = .systemFont(ofSize: Constants.buttonFontSize)
        addEventButton.backgroundColor = Constants.buttonBackgroundColor
        
        addEventButton.setHeight(Constants.buttonHeight)
        addEventButton.setWidth(Constants.buttonWidth)
        
        addEventButton.pinTop(to: self.safeAreaLayoutGuide.topAnchor, Constants.buttonTopPadding)
        addEventButton.pinRight(to: self)
        
        addEventButton.addTarget(self, action: #selector(addEventButtonTapped), for: .touchUpInside)
    }
    
    // MARK: -obj
    @objc
    private func addEventButtonTapped() {
        delegate?.didPressEvenCreationButton()
    }
}
