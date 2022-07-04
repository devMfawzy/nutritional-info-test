//
//  MainViewController.swift
//  Nutritional Info
//
//  Created by Mohamed Fawzy on 04/07/2022.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    private var mainView = NutritionalInfoView()
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: NutritionalInfoViewModel
    
    init(viewModel: NutritionalInfoViewModel = NutritionalInfoViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        fetchRandomNutritionalInfo()
        setUpTargets()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    private func bind() {
        viewModel.$nutritionalInfo
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [ weak self] nutritionalInformation in
                self?.mainView.update(data: nutritionalInformation)
            })
            .store(in: &cancellables)
        

        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &cancellables)
    }
    
    private lazy var stateValueHandler: (ViewModelState) -> Void = { [weak self] state in
        switch state {
        case .loading:
            self?.mainView.startLoading()
        case .finishedLoading:
            self?.mainView.finishLoading()
        case .error(let error):
            self?.mainView.finishLoading()
            self?.mainView.showError(error)
        }
    }
    
    private func setUpTargets() {
        mainView.moreInfoButton.addTarget(self, action: #selector(onTapMoreInfoNutton), for: .touchUpInside)
    }
}

extension MainViewController {
    private func fetchRandomNutritionalInfo() {
        let id = Int.random(in: 0...150)
        viewModel.fetchNutritionalInfo(foodId: id)
    }
    
    @objc private func onTapMoreInfoNutton() {
        fetchRandomNutritionalInfo()
    }
}

