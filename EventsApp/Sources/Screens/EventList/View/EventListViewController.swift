//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import UIKit

class EventListViewController: UIViewController {
    
    var viewModel: EventListViewModel!
        
    private lazy var barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"), style: .plain, target: self, action: #selector(tappedAddEventButton))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .gloabl
        title = "Events"
        
        barButtonItem.tintColor = .primary
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(barButtonItem, animated: true)
    }
    
    @objc private func tappedAddEventButton() {
        viewModel.tappedAddEvent()
    }
}
