//
//  TitleAndValueView.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
import UIKit

final class TitleAndValueView: UIView  {
    
    // MARK: - Private properties
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = Layout.spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Color.textSecondary.uiColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Color.textPrimary.uiColor
        label.textAlignment = .left
        return label
    }()
    
    private enum Layout {
        static let spacing: CGFloat = 6
    }
    
    // MARK: - Public methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(valueLabel)
        addSubview(contentStack)
        NSLayoutConstraint.activate([contentStack.topAnchor.constraint(equalTo: topAnchor),
                                     contentStack.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}

extension TitleAndValueView: Configurable {
    
    func configure(_ input: TitleAndValueViewModelType) {
        titleLabel.text = input.title + " :"
        valueLabel.text = input.value
    }
}
