//
//  NutritionalInfoViewModel.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation
import Combine

class NutritionalInfoViewModel: ObservableObject, NutritionalInfoViewModelProtocol {
    @Published private(set) var nutritionalInfo: NutritionalInfoRepresentable = NutritionalInfoRepresenter.default
    @Published private(set) var state: ViewModelState = .loading

    private let service: NutritionalInfoServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(service: NutritionalInfoServiceProtocol = NutritionalInfoService()) {
        self.service = service
    }
    
    func fetchNutritionalInfo(foodId: Int) {
        self.state = .loading
        service.nutritionalInformation(foodId)
            .map { NutritionalInfoRepresenter(model: $0.response) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] compeletion in
                if case let .failure(error) = compeletion {
                    self?.state = .error(error)
                }}, receiveValue: { [weak self] info  in
                    self?.nutritionalInfo = info
                    self?.state = .finishedLoading
                })
            .store(in: &cancellables)
    }
}
