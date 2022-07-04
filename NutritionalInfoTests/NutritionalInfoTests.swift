//
//  NutritionalInfoTests.swift
//  NutritionalInfoTests
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import XCTest
import Combine
@testable import Nutritional_Info

class NutritionalInfoTests: XCTestCase {
    private var service: NutritionalInfoServiceProtocol!
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: NutritionalInfoViewModel!
    private var viewController: MainViewController!
    
    override func setUp() {
        service = MockNutritionalService()
        viewModel = NutritionalInfoViewModel(service: service)
        viewController = MainViewController(viewModel: viewModel)
        viewController.loadViewIfNeeded()
    }

    override func tearDown() {
        cancellables.forEach { $0.cancel()}
        cancellables.removeAll()
        service = nil
        viewModel = nil
        viewController = nil
        super.tearDown()
    }

    func test_when_no_data_and_unknown_error_received() {
        // when
        let expectation = expectation(description: "expect unknow error")
        viewModel.fetchNutritionalInfo(foodId: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.002) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertEqual(viewController.mainView.caloriesView.alpha, 0)
        XCTAssertEqual(viewController.mainView.percentagesView.alpha, 0)
        XCTAssertEqual(viewController.mainView.errorLabel.alpha, 1)
        XCTAssertEqual(viewController.mainView.errorLabel.text, Error.unknown.description)
    }
    
    func test_when_data_received() {
        // given
        if let service = service as? MockNutritionalService {
            service.dummyData = .dummyData(title: "Pasta", calories: 400, carbs: 10, protein: 2.0, fat: 5.0)
        }
        // when
        let expectation = expectation(description: "expect receive data successfully")
        viewModel.fetchNutritionalInfo(foodId: 2)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.002) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertEqual(viewController.mainView.caloriesView.titleLabel.text, "PASTA") // should be upercased
        XCTAssertEqual(viewController.mainView.caloriesView.caloriesLabel.text, "400")
        XCTAssertEqual(viewController.mainView.percentagesView.carbsValueLabel.text, "10%")
        XCTAssertEqual(viewController.mainView.percentagesView.proteinValueLabel.text, "2%")
        XCTAssertEqual(viewController.mainView.percentagesView.fatValueLabel.text, "5%")
        XCTAssertEqual(viewController.mainView.errorLabel.alpha, 0)
        XCTAssertEqual(viewController.mainView.caloriesView.alpha, 1)
        XCTAssertEqual(viewController.mainView.percentagesView.alpha, 1)
    }
    
    func test_when_network_error_received() {
        // given
        if let service = service as? MockNutritionalService {
            service.error = .network
        }
        // when
        let expectation = expectation(description: "expect netwek error")
        viewModel.fetchNutritionalInfo(foodId: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.002) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertEqual(viewController.mainView.caloriesView.alpha, 0)
        XCTAssertEqual(viewController.mainView.percentagesView.alpha, 0)
        XCTAssertEqual(viewController.mainView.errorLabel.alpha, 1)
        XCTAssertEqual(viewController.mainView.errorLabel.text, Error.network.description)
    }
    
    func test_when_parsing_error_received() {
        // given
        if let service = service as? MockNutritionalService {
            service.error = .parsing
        }
        // when
        let expectation = expectation(description: "expect parsing data error")
        viewModel.fetchNutritionalInfo(foodId: 1)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.002) {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3)
        // then
        XCTAssertEqual(viewController.mainView.caloriesView.alpha, 0)
        XCTAssertEqual(viewController.mainView.percentagesView.alpha, 0)
        XCTAssertEqual(viewController.mainView.errorLabel.alpha, 1)
        XCTAssertEqual(viewController.mainView.errorLabel.text, Error.parsing.description)
    }
}
