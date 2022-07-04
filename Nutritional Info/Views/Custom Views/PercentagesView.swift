//
//  PercentagesView.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit

class PercentagesView: UIView {
    func updateView(carbs: String, protein: String, fat: String) {
        self.carbsValueLabel.text = carbs
        self.proteinValueLabel.text = protein
        self.fatValueLabel.text = fat
    }
    
    func updateLabelsAlpha(alpha: CGFloat) {
        [carbsValueLabel, proteinValueLabel, fatValueLabel].forEach { $0.alpha = alpha}
    }
    
    init() {
        super.init(frame: .zero)
        self.addSubviews()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private(set) lazy var carbsValueLabel: UILabel = LabelView(fontSize: 20)
    private(set) lazy var proteinValueLabel: UILabel = LabelView(fontSize: 20)
    private(set) lazy var fatValueLabel: UILabel = LabelView(fontSize: 20)
    
    //MARK: Private members

    private let hStack: UIStackView = {
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.distribution = .equalCentering
        hStack.alignment = .center
        return hStack
    }()
    
    private func addSubviews() {
        let labels = [LabelView(text: "CARBS", fontSize: 24), LabelView(text: "PROTEIN", fontSize: 24), LabelView(text: "FAT", fontSize: 24)]
        let values = [carbsValueLabel, proteinValueLabel, fatValueLabel]
        zip(labels, values).forEach { label, value in
            hStack.addArrangedSubview(createVStack(titleLabel: label, percentageLabel: value))
        }
        addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            hStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            hStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            hStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            hStack.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
    private func createVStack(titleLabel: UILabel, percentageLabel: UILabel) -> UIView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.alignment = .center
        vStack.spacing = 8
        let spacer = UIView()
        spacer.backgroundColor = .lightGray
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(spacer)
        vStack.addArrangedSubview(percentageLabel)
        NSLayoutConstraint.activate([
            spacer.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            spacer.heightAnchor.constraint(equalToConstant: 1)])
        return vStack
    }
}
