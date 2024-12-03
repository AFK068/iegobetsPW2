//
//  CustomSlider.swift
//  iegobetsPW2
//
//  Created by Ivan on 30.10.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    private enum Constants {
        static let backgroundColor: UIColor = .white
        static let titleTopPadding: CGFloat = 10
        static let titleLeadingPadding: CGFloat = 20
        static let sliderBottomPadding: CGFloat = 10
        static let sliderLeadingPadding: CGFloat = 20
    }
    
    // MARK: - Variables
    var valueChanged: ((Double) -> Void)?
    
    // MARK: - UI Components
    var slider = UISlider()
    var titleView = UILabel()
    
    // MARK: - Constructors
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Private methods
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false
        
        for view in [slider, titleView] {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleTopPadding),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.titleLeadingPadding),
            
            slider.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            slider.centerXAnchor.constraint(equalTo: centerXAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1 * Constants.sliderBottomPadding),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.sliderLeadingPadding)
        ])
    }
    
    // MARK: -obj
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
