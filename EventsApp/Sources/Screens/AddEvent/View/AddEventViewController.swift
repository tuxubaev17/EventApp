//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import UIKit
import SnapKit

class AddEventViewController: UIViewController {
    
    var viewModel: AddEventViewModel!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleSubtitleTableViewCell.self, forCellReuseIdentifier: TitleSubtitleTableViewCell.identifier)
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelEventListener()
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    private func viewModelEventListener() {
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.viewDidLoad()
    }
    
    private func setupView() {
        title = "Add Events"
        view.backgroundColor = .gloabl
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(tappedDone))
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    
    @objc private func tappedDone() {
        viewModel.tappedDone()
    }
}

extension AddEventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleTableViewCell.identifier, for: indexPath) as! TitleSubtitleTableViewCell
            cell.configure(with: titleSubtitleCellViewModel)
            cell.subTitleTextField.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AddEventViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            viewModel.updateCell(indexPath: indexPath, subtitle: text)
        }
        return true
    }
}

