//
//  WishEventCell.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import UIKit

final class WishEventCell : UICollectionViewCell {
    // MARK: - Constants
    private enum Constants {
        static let offset: CGFloat = 8
        static let cornerRadius: CGFloat = 12
        static let backgroundColor: UIColor = .lightGray
        static let titleTop: CGFloat = 8
        static let titleLeading: CGFloat = 16
        static let titleFont: UIFont = .boldSystemFont(ofSize: 16)
        static let descriptionFont: UIFont = .systemFont(ofSize: 14)
        static let dateFont: UIFont = .italicSystemFont(ofSize: 12)
        static let spacing: CGFloat = 4
        
        static let titleLableColor: UIColor = .black
        static let descriptionLabelColor: UIColor = .darkGray
        static let startDateLabelColor: UIColor = .darkGray
        static let endDateLabelColor: UIColor = .darkGray
    }
    
    static let reuseIdentifier: String = "WishEventCell"
    
    // MARK: - UI Components
    private var wrapView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var startDateLabel: UILabel = UILabel()
    private var endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func configure(with event: CalendarEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.title
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
    
    // MARK: - Private methods
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, Constants.offset)
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
    }
    
    private func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.textColor = Constants.titleLableColor
        titleLabel.pinTop(to: wrapView, Constants.titleTop)
        titleLabel.font = Constants.titleFont
        titleLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Constants.descriptionLabelColor
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.pinTop(to: titleLabel.bottomAnchor, Constants.spacing)
        descriptionLabel.pinLeft(to: wrapView, Constants.titleLeading)
        descriptionLabel.pinRight(to: wrapView, Constants.titleLeading)
    }
    
    private func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.textColor = Constants.startDateLabelColor
        startDateLabel.font = Constants.dateFont
        startDateLabel.pinTop(to: descriptionLabel.bottomAnchor, Constants.spacing)
        startDateLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
    
    private func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.textColor = Constants.endDateLabelColor
        endDateLabel.font = Constants.dateFont
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, Constants.spacing)
        endDateLabel.pinLeft(to: wrapView, Constants.titleLeading)
    }
}
