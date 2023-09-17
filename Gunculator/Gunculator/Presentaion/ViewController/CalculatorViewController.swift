//
//  ViewController.swift
//  Gunculator
//
//  Created by Gundy on 2023/09/16.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    private lazy var viewModel: CalculatorViewModel = {
        let viewModel = CalculatorViewModel()
        
        viewModel.delegate = self
        
        return viewModel
    }()
    private let containerStackView: UIStackView = UIStackView(spacing: 20,
                                                              axis: .vertical)
    private let logScrollView: UIScrollView = UIScrollView()
    private let logStackView: UIStackView = UIStackView(spacing: 8,
                                                        axis: .vertical)
    private lazy var screenStackView: UIStackView = UIStackView(arrangedSubviews: [signLabel, inputLabel], spacing: 8)
    private let signLabel: UILabel = UILabel(font: .preferredFont(forTextStyle: .largeTitle))
    private let inputLabel: UILabel = UILabel(text: "0",
                                              font: .preferredFont(forTextStyle: .largeTitle),
                                              textAlignment: .right)
    private let padStackView: UIStackView = UIStackView(spacing: 8,
                                                        axis: .vertical,
                                                        distribution: .fillEqually)
    private lazy var firstRowStackView: UIStackView = UIStackView(arrangedSubviews: [makeOperatorButton("C", isUpperPad: true), makeOperatorButton("←", isUpperPad: true), makeOperatorButton("⁺⁄₋", isUpperPad: true), makeOperatorButton("÷")],
                                                                  spacing: 8,
                                                                  axis: .horizontal,
                                                                  distribution: .fillEqually)
    private lazy var secondRowStackView: UIStackView = UIStackView(arrangedSubviews: [makeNumberButton("7"), makeNumberButton("8"), makeNumberButton("9"), makeOperatorButton("×")],
                                                                  spacing: 8,
                                                                  axis: .horizontal,
                                                                  distribution: .fillEqually)
    private lazy var thirdRowStackView: UIStackView = UIStackView(arrangedSubviews: [makeNumberButton("4"), makeNumberButton("5"), makeNumberButton("6"), makeOperatorButton("-")],
                                                                  spacing: 8,
                                                                  axis: .horizontal,
                                                                  distribution: .fillEqually)
    private lazy var forthRowStackView: UIStackView = UIStackView(arrangedSubviews: [makeNumberButton("1"), makeNumberButton("2"), makeNumberButton("3"), makeOperatorButton("+")],
                                                                  spacing: 8,
                                                                  axis: .horizontal,
                                                                  distribution: .fillEqually)
    private lazy var fifthRowStackView: UIStackView = UIStackView(arrangedSubviews: [makeNumberButton("0"), makeDotButton(), makeOperatorButton("=")],
                                                                  spacing: 8,
                                                                  axis: .horizontal,
                                                                  distribution: .fill)
    private lazy var clearButton: UIButton = makeOperatorButton("C", isUpperPad: true)
    private lazy var backspaceButton: UIButton = makeOperatorButton("←", isUpperPad: true)
    private lazy var signChangeButton: UIButton = makeOperatorButton("⁺⁄₋", isUpperPad: true)
    private lazy var divideButton: UIButton = makeOperatorButton("÷")
    private lazy var multiflyButton: UIButton = makeOperatorButton("×")
    private lazy var subtractButton: UIButton = makeOperatorButton("-")
    private lazy var addButton: UIButton = makeOperatorButton("+")
    private lazy var equalsButton: UIButton = makeOperatorButton("=")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewHierarchy()
        configureConstraints()
    }
    
    private func configureViewHierarchy() {
        view.addSubview(containerStackView)
        [logScrollView, screenStackView, padStackView].forEach({ containerStackView.addArrangedSubview($0) })
        logScrollView.addSubview(logStackView)
        [firstRowStackView, secondRowStackView, thirdRowStackView, forthRowStackView, fifthRowStackView].forEach({ padStackView.addArrangedSubview($0) })
    }
    
    private func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        guard let first = firstRowStackView.arrangedSubviews.first,
              let last = fifthRowStackView.arrangedSubviews.last,
              let zero = fifthRowStackView.arrangedSubviews.first else { return }
        
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            containerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            containerStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            logStackView.leadingAnchor.constraint(equalTo: logScrollView.contentLayoutGuide.leadingAnchor),
            logStackView.trailingAnchor.constraint(equalTo: logScrollView.contentLayoutGuide.trailingAnchor),
            logStackView.topAnchor.constraint(equalTo: logScrollView.contentLayoutGuide.topAnchor),
            logStackView.bottomAnchor.constraint(equalTo: logScrollView.contentLayoutGuide.bottomAnchor),
            logStackView.widthAnchor.constraint(equalTo: containerStackView.widthAnchor),
            first.widthAnchor.constraint(equalTo: first.heightAnchor),
            last.widthAnchor.constraint(equalTo: last.heightAnchor),
            zero.widthAnchor.constraint(equalTo: last.widthAnchor, multiplier: 2, constant: 8)
        ])
        signLabel.setContentHuggingPriority(.required, for: .horizontal)
    }
    
    private func makeOperatorButton(_ sign: String, isUpperPad: Bool = false) -> UIButton {
        return UIButton(primaryAction: makeOperatorAction(sign),
                        font: .preferredFont(forTextStyle: .largeTitle),
                        titleColor: isUpperPad ? .systemBackground : .white,
                        backgroundColor: isUpperPad ? .upperPad : .operator)
    }
    
    private func makeOperatorAction(_ sign: String) -> UIAction? {
        guard let `operator` = Operator(rawValue: sign) else { return nil }
        let action = UIAction(title: sign) { [weak self] _ in
            self?.viewModel.operate(by: `operator`)
        }
        
        return action
    }
    
    private func makeNumberButton(_ number: String) -> UIButton {
        return UIButton(primaryAction: makeOperandAction(number),
                        font: .preferredFont(forTextStyle: .largeTitle),
                        titleColor: .black,
                        backgroundColor: .numberPad)
    }
    
    private func makeDotButton() -> UIButton {
        return UIButton(primaryAction: makeOperandAction("."),
                        font: .preferredFont(forTextStyle: .largeTitle),
                        titleColor: .label,
                        backgroundColor: .dot)
    }
    
    private func makeOperandAction(_ input: String) -> UIAction {
        let action = UIAction(title: input) { [weak self] _ in
            self?.viewModel.input(input)
        }
        
        return action
    }
    
    private func appendLogLabel(_ expression: String) {
        let label = UILabel(text: expression,
                            font: .preferredFont(forTextStyle: .body),
                            textAlignment: .right)
        
        logStackView.addArrangedSubview(label)
    }
    
    private func scrollToLast() {
        logScrollView.layoutIfNeeded()
        guard logScrollView.contentSize.height > logScrollView.frame.height else { return }
        let offset = logScrollView.contentSize.height - logScrollView.frame.height
        logScrollView.setContentOffset(CGPoint(x: 0, y: offset),
                                       animated: true)
    }
}

extension CalculatorViewController: CalculatorViewModelDelegate {
    
    func viewModel(willDisplayNumber inputted: String) {
        inputLabel.text = inputted
    }
    
    func viewModel(willDisplaySign inputted: String?) {
        signLabel.text = inputted
    }
    
    func viewModel(willAppend expression: String) {
        appendLogLabel(expression)
        scrollToLast()
    }
}
