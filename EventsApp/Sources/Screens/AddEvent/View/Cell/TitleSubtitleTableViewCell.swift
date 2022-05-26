//
//  TitleSubtitleTableViewCell.swift
//  EventsApp
//
//  Created by Alikhan on 25.05.2022.
//

import UIKit
import SnapKit

enum Constants {
    static let padding: CGFloat = 15
    static let imageHeight = 200
}

final class TitleSubtitleTableViewCell: UITableViewCell {
    static let identifier = "TitleSubtitleTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        return label
    }()
    
    lazy var subTitleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        return textField
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let datePickerView: UIDatePicker = {
        let dataPicker = UIDatePicker()
        dataPicker.preferredDatePickerStyle = .wheels
        dataPicker.datePickerMode = .date
        return dataPicker
    }()
    
    private let toolBar = UIToolbar(frame: .init(x: 0, y: 0, width: 100, height: 45))
    private lazy var doneButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDoneButton))
        return button
    }()
    
    private lazy var imagView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black.withAlphaComponent(0.4)
        image.layer.cornerRadius = 10
        return image
    }()
    
    private var viewModel: TitleSubtitleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        toolBar.setItems([doneButton], animated: false)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        [titleLabel, subTitleTextField, imagView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
        verticalStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.padding)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-Constants.padding)
            make.left.equalToSuperview().offset(Constants.padding)
        }
        imagView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-Constants.padding)
            make.height.equalTo(Constants.imageHeight)
        }
    }
    
    @objc private func tappedDoneButton() {
        viewModel?.update(datePickerView.date)
    }
    
    func configure(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subTitleTextField.text = viewModel.subTitle
        subTitleTextField.placeholder = viewModel.placeholder
        subTitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subTitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        
        imagView.isHidden = viewModel.type != .image
        subTitleTextField.isHidden = viewModel.type == .image
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
}
