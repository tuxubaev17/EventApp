//
//  EventCell.swift
//  EventsApp
//
//  Created by Alikhan on 27.05.2022.
//

import UIKit

private enum Constant {
    static let padding: CGFloat = 15
    static let imageHeight: CGFloat = 250
}

final class EventCell: UITableViewCell {
    static let identifier = "EventCell"
    
    private let timeRemainingStackView = TimeRemainingStackView()
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private let daysLabel = UILabel()
    private let weekLabel = UILabel()
    private let dateLabel = UILabel()
    private let backgroundImageView = UIImageView()
    
    private lazy var nameOfEventLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
        setupViews()
        setupHierarch()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        timeRemainingStackView.setup()
        
        [dateLabel, nameOfEventLabel, backgroundImageView, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
    }
    
    private func setupHierarch() {
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(nameOfEventLabel)
        
        verticalStackView.addArrangedSubview(timeRemainingStackView)
        verticalStackView.addArrangedSubview(UIView())
        verticalStackView.addArrangedSubview(dateLabel)
        
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperView()
        backgroundImageView.heightAnchor.constraint(equalToConstant: Constant.imageHeight).isActive = true
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        verticalStackView.pinToSuperView([.top, .right, .bottom], constant: Constant.padding)
        nameOfEventLabel.pinToSuperView([.left, .bottom], constant: Constant.padding)
    }
    
    func configure(with model: EventCellViewModel) {
        if let timeRemainingViewModel = model.timeRemainingViewModel {
            timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        dateLabel.text = model.dateText
        nameOfEventLabel.text = model.eventName
        model.loadImage { [weak self] image in
            self?.backgroundImageView.image = image
        }
    }
}
