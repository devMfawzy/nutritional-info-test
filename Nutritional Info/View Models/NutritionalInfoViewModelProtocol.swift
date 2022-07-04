//
//  NutritionalInfoViewModelProtocol.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation

protocol NutritionalInfoViewModelProtocol: AnyObject {
    var nutritionalInfo: NutritionalInfoRepresentable { get }
    var state: ViewModelState { get }
    func fetchNutritionalInfo(foodId: Int)
}
