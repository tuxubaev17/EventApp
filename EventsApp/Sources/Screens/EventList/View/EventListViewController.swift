//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import UIKit
import SnapKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
        
    private lazy var barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(tappedAddEventButton))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.identifier)
//        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
//        tableView.tableFooterView = UIView()
//        tableView.separatorStyle = .none
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
    
    private func setupView() {
        view.backgroundColor = .gloabl
        title = "Events"
        
        barButtonItem.tintColor = .primary
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }
    
    private func viewModelEventListener() {
        viewModel.updateCell()

        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case let .event(eventCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as! EventCell
            cell.configure(with: eventCellViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}
