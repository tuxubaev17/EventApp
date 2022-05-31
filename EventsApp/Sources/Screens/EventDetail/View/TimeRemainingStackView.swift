//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by Alikhan on 31.05.2022.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    private let timeRemainigLabels = [UILabel(), UILabel(), UILabel(), UILabel()]

    func setup() {
        timeRemainigLabels.forEach {
            addArrangedSubview($0)
        }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func update(with viewModel: TimeRemainingViewModel) {
        timeRemainigLabels.forEach {
            $0.text = ""
            $0.font = .systemFont(ofSize: viewModel.fontSize, weight: .medium)
            $0.textColor = .white
        }
        
        viewModel.timeRemainingParts.enumerated().forEach {
            timeRemainigLabels[$0.offset].text = $0.element
        }
        alignment = viewModel.aligment
    }
}

