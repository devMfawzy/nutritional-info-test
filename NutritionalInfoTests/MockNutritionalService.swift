//
//  MockNutritionalService.swift
//  NutritionalInfoTests
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import Foundation
import Combine
@testable import Nutritional_Info

final class MockNutritionalService: NutritionalInfoServiceProtocol {
    private let subject = PassthroughSubject<NutritionalInformationResult, Error>()
    var error: Error?
    var dummyData: NutritionalInformationResult?
    var responseTime = 0.0001
    
    init(error: Error?=nil, dummyData: NutritionalInformationResult?=nil) {
        self.error = error
        self.dummyData = dummyData
    }

    func nutritionalInformation(_ foodId: Int) -> AnyPublisher<NutritionalInformationResult, Error> {
        DispatchQueue.main.asyncAfter(deadline: .now()+responseTime) { [weak self] in
            guard let self = self else { return }
            if let error = self.error {
                self.subject.send(completion: .failure(error))
            } else if let dummyData = self.dummyData {
                self.subject.send(dummyData)
            } else {
                self.subject.send(completion: .failure(.unknown))
            }
        }
        return subject.eraseToAnyPublisher()
    }
}

extension NutritionalInformationResult {
    static func dummyData(title: String, calories: Int, carbs: Float, protein: Float, fat: Float) -> NutritionalInformationResult {
        NutritionalInformationResult(
            meta: ResponseMeta(code: 200),
            response: NutritionalInformation(title: title, calories: calories, carbs: carbs, protein: protein, fat: fat))
    }
}
