//
//  WishMakerViewController.swift
//  iegobetsPW2
//
//  Created by Ivan on 30.10.2024.
//

import UIKit

final class WishMakerViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let alphaValue: CGFloat = 1
        
        static let stackRadius: CGFloat = 20
        static let stackBottom: CGFloat = -40
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
    }
    
    // MARK: - Variables
    var titleLable = UILabel()
    var descriptionLable = UILabel()
    var stack = UIStackView()
    
    var hideButton = UIButton()
    var randomColorButton = UIButton()
    var hexColorButton = UIButton()
    
    var stackIsHidden: Bool = false
    
    // MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: -Private methods
    private func configureUI() {
        configurateTitle()
        configureDescription()
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
        view.addSubview(titleLable)
        
        titleLable.pinCenterX(to: view)
        titleLable.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTopAnchor)
    }
    
    private func configureDescription() {
        descriptionLable.translatesAutoresizingMaskIntoConstraints = false
        descriptionLable.text = Constants.descriptionText
        descriptionLable.textColor = .white
        descriptionLable.font = UIFont.boldSystemFont(ofSize: Constants.descriptionFontSize)
        view.addSubview(descriptionLable)
        
        descriptionLable.pinLeft(to: view, Constants.descriptionLeftAnchor)
        descriptionLable.pinTop(to: titleLable.bottomAnchor, Constants.descriptionTopAnchor)
    }
    
    private func configureSliders() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
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
        
        stack.pinBottom(to: view, -1 * Constants.stackBottom) // bottom makes constant negative for us
        stack.pinHorizontal(to: view, Constants.stackLeading)
    }
    
    private func updateBackgroundColor(red: Double, green: Double, blue: Double) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.alphaValue)
    }
    
    private func configurateHideButton() {
        stack.addArrangedSubview(hideButton)
        hideButton.setTitle(Constants.buttonTextToHide, for: .normal)
        hideButton.setTitleColor(.black, for: .normal)
        hideButton.backgroundColor = UIColor.white
        hideButton.addTarget(self, action: #selector(hideSliders), for: .touchUpInside)
    }
    
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
    
    private func configurateRandomColorButton() {
        stack.addArrangedSubview(randomColorButton)
        randomColorButton.setTitle(Constants.randomColorButtonText, for: .normal)
        randomColorButton.setTitleColor(.black, for: .normal)
        randomColorButton.backgroundColor = UIColor.white
        randomColorButton.addTarget(self, action: #selector(randomColor), for: .touchUpInside)
    }
    
    @objc
    private func randomColor() {
        let randomRed = Float.random(in: 0...Constants.colorComponentRangeMaxValue)
        let randomGreen = Float.random(in: 0...Constants.colorComponentRangeMaxValue)
        let randomBlue = Float.random(in: 0...Constants.colorComponentRangeMaxValue)
        
        changeSliders(red: randomRed, green: randomGreen, blue: randomBlue)
        
        view.backgroundColor = UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: Constants.alphaValue)
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
    
    private func configurateHEXColorButton() {
        stack.addArrangedSubview(hexColorButton)
        hexColorButton.setTitle(Constants.hexColorButtonText, for: .normal)
        hexColorButton.setTitleColor(.black, for: .normal)
        hexColorButton.backgroundColor = UIColor.white
        hexColorButton.addTarget(self, action: #selector(hexColor), for: .touchUpInside)
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
        present(alert, animated: true)
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
                view.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: Constants.alphaValue)
            }
        }
    }
}
