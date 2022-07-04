//
//  NutritionalInfoView.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit

class NutritionalInfoView: UIView {
    func update(data: NutritionalInfoRepresentable) {
        caloriesView.updateView(title: data.title, value: data.calories)
        percentagesView.updateView(carbs: data.carbs, protein: data.protein, fat: data.fat)
    }
        
    func startLoading() {
        self.moreInfoButton.isEnabled = false
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.percentagesView.updateLabelsAlpha(alpha: 0.5)
        }
        let fromColor = UIColor.init(red: 66/255, green: 245/255, blue: 221/255, alpha: 0.7)
        let toColor = UIColor.init(red: 250/255, green: 185/255, blue: 87/255, alpha: 0.7)
        caloriesView.animateBorderColor(fromColor: fromColor, toColor: toColor, duration: 0.5)
        errorLabel.alpha = 0
        caloriesView.alpha = 1
        percentagesView.alpha = 1
    }
    
    func finishLoading() {
        self.moreInfoButton.isEnabled = true
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.percentagesView.updateLabelsAlpha(alpha: 1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) { [weak self] in
            self?.caloriesView.stopBorderAnimation()
        }
    }
    
    func showError(_ error: Error) {
        errorLabel.text = error.description
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.caloriesView.alpha = 0
            self.percentagesView.alpha = 0
            self.errorLabel.alpha = 1
        }
    }
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setUpConstraints()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        moreInfoButton.layer.cornerRadius = 36
    }
        
   let caloriesView: CaloriesView = {
        let gradientColors = [UIColor.gradientStartColor, UIColor.gradientEndColor].compactMap { $0 }
        return CaloriesView(description: "Calories per serving", borderWidth: 15, borderColor: .clear, gradientColors: gradientColors)
    }()
        
    private(set) lazy var errorLabel: UILabel = {
        let label = LabelView(color: .systemPink, fontSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    let percentagesView = PercentagesView()
    
    let moreInfoButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("More Info", for: .normal)
        button.setTitleColor(.white, for: [])
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .moreInfoButtonColor
        return button
    }()

    //MARK: Private members

    private func addSubviews() {
        [caloriesView, moreInfoButton, percentagesView, errorLabel]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            caloriesView.centerXAnchor.constraint(equalTo: centerXAnchor),
            caloriesView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            caloriesView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.73),
            caloriesView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.73),
            percentagesView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7),
            percentagesView.leadingAnchor.constraint(equalTo: caloriesView.leadingAnchor),
            percentagesView.trailingAnchor.constraint(equalTo: caloriesView.trailingAnchor),
            percentagesView.bottomAnchor.constraint(equalTo: moreInfoButton.topAnchor, constant: -100),
            errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: percentagesView.bottomAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: moreInfoButton.topAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -16),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            moreInfoButton.heightAnchor.constraint(equalToConstant: 75),
            moreInfoButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            moreInfoButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            moreInfoButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
    
    private func setUpViews() {
        self.backgroundColor = .white
        self.errorLabel.alpha = 0
        self.percentagesView.alpha = 0
        self.caloriesView.alpha = 0
    }
}
