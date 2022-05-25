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
        tableView.dataSource = self
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
        view.backgroundColor = .gloabl
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
}

extension AddEventViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(for: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleTableViewCell.identifier, for: indexPath) as! TitleSubtitleTableViewCell
            cell.configure(with: titleSubtitleCellViewModel)
            return cell
        case .titleImage:
            return UITableViewCell()
        }
    }
}
