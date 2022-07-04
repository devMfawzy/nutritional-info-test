//
//  ViewModelState.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation

enum ViewModelState: Equatable {
    case loading
    case finishedLoading
    case error(Error)
}
