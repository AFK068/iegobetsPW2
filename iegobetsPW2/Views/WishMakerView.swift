//
//  WishMakerView.swift
//  iegobetsPW2
//
//  Created by Ivan on 02.11.2024.
//

import UIKit

class WishMakerView: UIView {
    // MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let alphaValue: CGFloat = 1
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = 20
        static let stackLeading: CGFloat = 20
        
        static let titleFontSize: CGFloat = 32
        static let descriptionFontSize: CGFloat = 16
        
        static let titleTopAnchor: CGFloat = 30
        static let descriptionLeftAnchor : CGFloat = 20
        static let descriptionTopAnchor: CGFloat = 20
        
        static let colorComponentRangeMaxValue: Float = 1
        static let animationDuration: TimeInterval = 0.35
        static let colorComponentMax: CGFloat = 255.0
        static let hexColorLength: Int = 6
        
        static let redMask: UInt64 = 0xFF0000
        static let greenMask: UInt64 = 0x00FF00
        static let blueMask: UInt64 = 0x0000FF
        
        static let redShift: UInt64 = 16
        static let greenShift: UInt64 = 8
        
        static let buttomStackSpace: CGFloat = 20
        
        static let titleText = "WishMaker"
        static let descriptionText = "Very good app"
        static let buttonTextToHide = "Hide"
        static let buttonTestToShow = "Show"
        static let randomColorButtonText = "Random Color"
        static let hexColorButtonText = "HEX Color"
        static let alertTitle = "Enter HEX color"
        static let alertPlaceholder = "HEX format : #FFFFFF"
        static let alertSetActionTitle = "Set"
        static let alertCancelActionTitle = "Cancel"
        static let calendarButtonText = "Schedule wish granting"
        static let buttonText = "My wishes"
        
        static let buttonHeight: Double = 50
        static let buttonBottom: Double = 50
        static let buttonSide: Double = 20
        static let buttonRadius: Double = 20
    }

    // MARK: - Variables
    weak var delegate: WishMakerViewDelegate?
    
    var titleLable = UILabel()
    var descriptionLable = UILabel()
    
    var stack = UIStackView()
    var buttonStack = UIStackView()
    
    var addWishButton: UIButton = UIButton(type: .system)
    var hideButton = UIButton()
    var randomColorButton = UIButton()
    var hexColorButton = UIButton()
    var calendarButton: UIButton = UIButton(type: .system)
    
    var stackIsHidden: Bool = false
    
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
        configurateTitle()
        configureDescription()
        configurateButtonStack()
        configureSliders()
        configurateHideButton()
        configurateRandomColorButton()
        configurateHEXColorButton()
    }
    
    private func configurateTitle() {
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        titleLable.text = Constants.titleText
        titleLable.textColor = .white
        titleLable.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        self.addSubview(titleLable)
        
        titleLable.pinCenterX(to: self)
        titleLable.pinTop(to: self.safeAreaLayoutGuide.topAnchor, Constants.titleTopAnchor)
    }
    
    private func configureDescription() {
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.text = Constants.descriptionText
        descriptionLable.textColor = .white
        descriptionLable.font = UIFont.boldSystemFont(ofSize: Constants.descriptionFontSize)
        self.addSubview(descriptionLable)
        
        descriptionLable.pinLeft(to: self, Constants.descriptionLeftAnchor)
        descriptionLable.pinTop(to: titleLable.bottomAnchor, Constants.descriptionTopAnchor)
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        self.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderGreen, sliderBlue] {
            stack.addArrangedSubview(slider)
        }
        
        sliderRed.valueChanged = { [weak self] value in
            self?.updateBackgroundColor(red: value, green: Double(sliderGreen.slider.value), blue: Double(sliderBlue.slider.value))
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.updateBackgroundColor(red: Double(sliderRed.slider.value), green: value, blue: Double(sliderBlue.slider.value))
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.updateBackgroundColor(red: Double(sliderRed.slider.value), green: Double(sliderGreen.slider.value), blue: value)
        }
        
        stack.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
        stack.pinHorizontal(to: self, Constants.stackLeading)
    }
    
    private func configurateHideButton() {
        stack.addArrangedSubview(hideButton)
        hideButton.setTitle(Constants.buttonTextToHide, for: .normal)
        hideButton.setTitleColor(.black, for: .normal)
        hideButton.backgroundColor = UIColor.white
        hideButton.addTarget(self, action: #selector(hideSliders), for: .touchUpInside)
    }
    
    private func configurateRandomColorButton() {
        stack.addArrangedSubview(randomColorButton)
        randomColorButton.setTitle(Constants.randomColorButtonText, for: .normal)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.backgroundColor = UIColor.white
        randomColorButton.addTarget(self, action: #selector(randomColor), for: .touchUpInside)
    }
    
    private func configurateHEXColorButton() {
        stack.addArrangedSubview(hexColorButton)
        hexColorButton.setTitle(Constants.hexColorButtonText, for: .normal)
        hexColorButton.setTitleColor(.black, for: .normal)
        hexColorButton.backgroundColor = UIColor.white
        hexColorButton.addTarget(self, action: #selector(hexColor), for: .touchUpInside)
    }
    
    private func configurateButtonStack() {
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .vertical
        self.addSubview(buttonStack)
        buttonStack.spacing = Constants.buttomStackSpace
        
        buttonStack.addArrangedSubview(addWishButton)
        buttonStack.addArrangedSubview(calendarButton)
        
        buttonStack.pinBottom(to: self, Constants.buttonBottom)
        buttonStack.pinHorizontal(to: self, Constants.buttonSide)
        
        configureAddWishButton()
        configurateСalendarButton()
    }
    
    private func configureAddWishButton() {
        addWishButton.setHeight(Constants.buttonHeight)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    private func configurateСalendarButton() {
        calendarButton.setHeight(Constants.buttonHeight)
        
        calendarButton.backgroundColor = .white
        calendarButton.setTitleColor(.systemPink, for: .normal)
        calendarButton.setTitle(Constants.calendarButtonText, for: .normal)
        
        calendarButton.layer.cornerRadius = Constants.buttonRadius
    }
    
    private func updateBackgroundColor(red: Double, green: Double, blue: Double) {
        self.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.alphaValue)
    }
    
    private func changeColorUsingHEX(hex: String) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == Constants.hexColorLength {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & Constants.redMask) >> Constants.redShift) / Constants.colorComponentMax
                    g = CGFloat((hexNumber & Constants.greenMask) >> Constants.greenShift) / Constants.colorComponentMax
                    b = CGFloat(hexNumber & Constants.blueMask) / Constants.colorComponentMax
                }
                
                changeSliders(red: Float(r), green: Float(g), blue: Float(b))
                self.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: Constants.alphaValue)
            }
        }
    }
    
    private func changeSliders(red: Float, green: Float, blue: Float) {
        for subview in self.stack.arrangedSubviews {
            if let slider = subview as? CustomSlider {
                if slider.titleView.text == Constants.red {
                    slider.slider.value = red
                } else if slider.titleView.text == Constants.green {
                    slider.slider.value = green
                } else if slider.titleView.text == Constants.blue {
                    slider.slider.value = blue
                }
            }
        }
    }
    
    // MARK: -obj
    @objc
    private func hideSliders() {
        stackIsHidden.toggle()
        let changedTitile = stackIsHidden ? Constants.buttonTestToShow : Constants.buttonTextToHide
        hideButton.setTitle(changedTitile, for: .normal)
        
        UIView.animate(withDuration: Constants.animationDuration) {
            for subview in self.stack.arrangedSubviews {
                if let slider = subview as? CustomSlider {
                    slider.isHidden.toggle()
                }
            }
        }
    }
    
    @objc
    private func randomColor() {
        let randomRed = Float.random(in: 0...Constants.colorComponentRangeMaxValue)
        let randomGreen = Float.random(in: 0...Constants.colorComponentRangeMaxValue)
        let randomBlue = Float.random(in: 0...Constants.colorComponentRangeMaxValue)
        
        changeSliders(red: randomRed, green: randomGreen, blue: randomBlue)
        
        self.backgroundColor = UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: Constants.alphaValue)
    }
    
    @objc
    private func hexColor() {
        let alert = UIAlertController(title: Constants.alertTitle, message: nil, preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = Constants.alertPlaceholder
        }
        
        let setAction = UIAlertAction(title: Constants.alertSetActionTitle, style: .default) { [weak self] _ in
            guard let textFields = alert.textFields?.first?.text else { return }
            self?.changeColorUsingHEX(hex: textFields)
        }
        
        alert.addAction(setAction)
        alert.addAction(UIAlertAction(title: Constants.alertCancelActionTitle, style: .cancel))
        delegate?.presentAlert(alert)
    }
    
    @objc
    private func addWishButtonPressed() {
        delegate?.didPressAddWishButton()   
    }
}
