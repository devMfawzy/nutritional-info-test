//
//  LabelView.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit

class LabelView: UILabel {
    init(text: String = "", color: UIColor = .gray, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.text = text
        font = .systemFont(ofSize: fontSize)
        textColor = color
        textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

