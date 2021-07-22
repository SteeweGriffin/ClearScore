//
//  DashboardView.swift
//  ClearScoreExample
//
//  Created by Raffaele Cerullo on 22/07/2021.
//

import Foundation
import UIKit

final class DashboardCircleView: UIView, Tappable {
    
    // MARK: - Public properties
    
    var tapAction: (() -> ())?
    var tapEnabled: Bool = false {
        didSet { tapButton.isEnabled = tapEnabled }
    }
    
    // MARK: - Private properties
    
    private var viewModel: DashboardCircleViewModelType?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Color.textPrimary.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 70, weight: .ultraLight)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Color.accent.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .title2)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = Color.textPrimary.uiColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = Layout.spacing
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.addArrangedSubview(subtitleLabel)
        return stackView
    }()
    
    private lazy var baseCircle: CAShapeLayer = {
        
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = Color.accent.uiColor.withAlphaComponent(0.3).cgColor
        circleLayer.lineWidth = Layout.baseLineWidth
        circleLayer.lineCap = .round
        circleLayer.strokeEnd = 1
        
        return circleLayer
    }()
    
    private lazy var valueCircle: CAShapeLayer = {
        
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = Color.accent.uiColor.cgColor
        circleLayer.lineWidth = Layout.valueLineWidth
        circleLayer.lineCap = .round
        circleLayer.strokeEnd = 0
        
        return circleLayer
    }()
    
    private var circlePath: UIBezierPath {
        let startAngle: CGFloat = -CGFloat(Double.pi / 2)
        let endAngle: CGFloat = CGFloat(Double.pi * 2) + startAngle
        return UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                               y: frame.size.height / 2.0),
                            radius: (frame.size.width - Layout.padding * 2)/2,
                            startAngle: startAngle,
                            endAngle: endAngle,
                            clockwise: true)
    }
    
    private lazy var tapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.tapAction?()
        }), for: .touchUpInside)
        return button
    }()
    
    private enum Layout {
        static let spacing: CGFloat = 4
        static let padding: CGFloat = 20
        static let baseLineWidth: CGFloat = 30
        static let valueLineWidth: CGFloat = 22
    }
    
    // MARK: - Public methods
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        baseCircle.path = circlePath.cgPath
        valueCircle.path = circlePath.cgPath
    }
    
    func startAnimation() {
        guard let percentage = viewModel?.valuePercentage else { return }
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = CGFloat(percentage)
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        valueCircle.add(animation, forKey: nil)
    }
    
    // MARK: - Private methods
    
    private func setupUI() {
        backgroundColor = .clear
        addSubview(infoStack)
        NSLayoutConstraint.activate([infoStack.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     infoStack.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     infoStack.leftAnchor.constraint(equalTo: leftAnchor, constant: Layout.padding),
                                     infoStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -Layout.padding)])
        
        layer.addSublayer(baseCircle)
        layer.addSublayer(valueCircle)
        addSubview(tapButton)
        NSLayoutConstraint.activate([tapButton.topAnchor.constraint(equalTo: topAnchor),
                                     tapButton.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     tapButton.leftAnchor.constraint(equalTo: leftAnchor),
                                     tapButton.rightAnchor.constraint(equalTo: rightAnchor)])
        tapEnabled = false
    }
}

extension DashboardCircleView: Configurable {
    
    func configure(_ input: DashboardCircleViewModelType?) {
        guard let viewModel = input else { return }
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        valueLabel.text = viewModel.valueString
        valueCircle.strokeEnd = CGFloat(viewModel.valuePercentage)
        tapEnabled = true
    }
    
}
