//
//  DetailViewController.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let viewModel: DetailViewModelType
    
    private enum Layout {
        static let spacing: CGFloat = 20
        static let padding: CGFloat = 20
    }
    
    // MARK: - Public methods
    
    required init(input: DetailViewModelType) {
        viewModel = input
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        view.backgroundColor = Color.background.uiColor
        title = viewModel.screenTitle
        
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .top
        stackView.axis = .vertical
        stackView.spacing = Layout.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.padding),
                                     stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Layout.padding),
                                     stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Layout.padding)])
        
        let inputs = [viewModel.personaType,
                     viewModel.score,
                     viewModel.scoreBand,
                     viewModel.currentShortTermDebt,
                     viewModel.currentShortTermCreditLimit,
                     viewModel.currentLongTermDebt,
                     viewModel.daysUntilNextReport]
        
        inputs.forEach { input in
            let viewModel =  TitleAndValueViewModel(title: input.title, value: input.value)
            let view = TitleAndValueView.makeConfiguratedView(viewModel)
            view.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(view)
        }
    }
}
