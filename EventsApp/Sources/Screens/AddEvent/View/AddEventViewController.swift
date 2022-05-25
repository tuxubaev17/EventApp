//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import UIKit

class AddEventViewController: UIViewController {
    
    var viewModel: AddEventViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    func setupView() {
        view.backgroundColor = .gloabl
    }
}
