//
//  CaloriesView.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit

class CaloriesView: CircleView {
    init(description: String, borderWidth: CGFloat, borderColor: UIColor, gradientColors: [UIColor]) {
        super.init(borderWidth: borderWidth, borderColor: borderColor, gradientColors: gradientColors)
        self.caloriesDescription.text = description
        self.addSubviews()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(title: String, value: String) {
        self.titleLabel.text = title
        self.caloriesLabel.text = value
    }
        
    private(set) lazy var titleLabel: UILabel = {
        let label = LabelView(color: .white, fontSize: 24)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private(set) lazy var caloriesLabel: UILabel = LabelView(color: .white, fontSize: 55)
    
    //MARK: Private members
    
    private let seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var caloriesDescription: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 18)
        label.alpha = 0.9
        label.textColor = .white
        return label
    }()
    
    private func addSubviews() {
        [titleLabel, seperator, caloriesLabel, caloriesDescription]
            .forEach {
                addSubview($0)
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            titleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220),
            seperator.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 1),
            seperator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            seperator.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            caloriesLabel.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            caloriesLabel.topAnchor.constraint(equalTo: seperator.bottomAnchor, constant: 10),
            caloriesDescription.centerXAnchor.constraint(equalTo: titleLabel.centerXAnchor),
            caloriesDescription.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 5),
        ])
    }
}
