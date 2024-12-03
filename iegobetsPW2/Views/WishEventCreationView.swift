//
//  WishEventCreationView.swift
//  iegobetsPW2
//
//  Created by Ivan on 03.12.2024.
//

import UIKit

final class WishEventCreationView : UIView {
    // MARK: - Constants
    private enum Constants {
        static let stackViewWidth: CGFloat = 400
        static let stackViewSpacing: CGFloat = 16
        static let textFieldWidth: CGFloat = 200
        static let descriptionFieldWidth: CGFloat = 200
        static let descriptionFieldHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 200
        static let buttonHeight: CGFloat = 30
        static let buttonCornerRadius: CGFloat = 10
        
        static let titlePlaceholder = "Event Title"
        static let descriptionPlaceholder = "Event Description"
        static let saveButtonTitle = "Save Event"
        
        static let buttonBackgroundColor: UIColor = .black
        
        static let stackAlignment: UIStackView.Alignment = .center
        static let stackAxis: NSLayoutConstraint.Axis = .vertical
        
        static let datePickerMode: UIDatePicker.Mode = .dateAndTime
        
        static let borderStyle: UITextField.BorderStyle = .roundedRect
    }
    
    // MARK: - Variables
    var titleTextField: UITextField = UITextField()
    var descriptionTextField: UITextField = UITextField()
    var startDatePicker: UIDatePicker = UIDatePicker()
    var endDatePicker: UIDatePicker = UIDatePicker()
    var saveButton: UIButton = UIButton(type: .system)
    var eventCreationStack = UIStackView()
    
    // MARK: - Delegates
    weak var delegate: WishEventCreationViewDelegate?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func configureUI() {
        configurateStackView()
        configurateTitleTextField()
        configurateDescriptionTextField()
        configurateDatePicker()
        configurateSaveButton()
    }
    
    private func configurateStackView() {
        self.addSubview(eventCreationStack)
        
        eventCreationStack.setWidth(Constants.stackViewWidth)
        eventCreationStack.axis = Constants.stackAxis
        eventCreationStack.spacing = Constants.stackViewSpacing
        eventCreationStack.alignment = Constants.stackAlignment
        
        eventCreationStack.pinCenter(to: self)
    }
    
    private func configurateTitleTextField() {
        eventCreationStack.addArrangedSubview(titleTextField)
        
        titleTextField.placeholder = Constants.titlePlaceholder
        titleTextField.setWidth(Constants.textFieldWidth)
        titleTextField.borderStyle = Constants.borderStyle
    }
    
    private func configurateDescriptionTextField() {
        eventCreationStack.addArrangedSubview(descriptionTextField)
        
        descriptionTextField.placeholder = Constants.descriptionPlaceholder
        descriptionTextField.borderStyle = Constants.borderStyle

        descriptionTextField.setWidth(Constants.descriptionFieldWidth)
        descriptionTextField.setHeight(Constants.descriptionFieldHeight)
    }
    
    private func configurateDatePicker() {
        eventCreationStack.addArrangedSubview(startDatePicker)
        eventCreationStack.addArrangedSubview(endDatePicker)
        
        startDatePicker.datePickerMode = Constants.datePickerMode
        endDatePicker.datePickerMode = Constants.datePickerMode
    }
    
    private func configurateSaveButton() {
        eventCreationStack.addArrangedSubview(saveButton)
        
        saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        saveButton.backgroundColor = Constants.buttonBackgroundColor
        saveButton.setWidth(Constants.buttonWidth)
        saveButton.setHeight(Constants.buttonHeight)
        saveButton.layer.cornerRadius = Constants.buttonCornerRadius
        
        saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func saveButtonPressed() {
        guard let title = titleTextField.text,
              !title.isEmpty,
              let description = descriptionTextField.text,
              let startDate = startDatePicker.date as Date?,
              let endDate = endDatePicker.date as Date? else {
            return
        }
        
        let eventModel = CalendarEventModel(title: title, startDate: startDate, endDate: endDate, note: description)
        delegate?.saveButtonPressed(with: eventModel)
    }
}
