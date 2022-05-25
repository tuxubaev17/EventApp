//
//  TitleSubtitleTableViewCell.swift
//  EventsApp
//
//  Created by Alikhan on 25.05.2022.
//

import UIKit
import SnapKit

enum Constants {
    static let leftOffset = 5
    static let padding: CGFloat = 15
}

final class TitleSubtitleTableViewCell: UITableViewCell {
    static let identifier = "TitleSubtitleTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    private lazy var subTitleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        return textField
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        [titleLabel, subTitleTextField].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.padding)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(Constants.padding)
        }
    }
    
    func configure(with viewModel: TitleSubtitleCellViewModel) {
        titleLabel.text = viewModel.title
        subTitleTextField.text = viewModel.subTitle
        subTitleTextField.placeholder = viewModel.placeholder
    }
}
