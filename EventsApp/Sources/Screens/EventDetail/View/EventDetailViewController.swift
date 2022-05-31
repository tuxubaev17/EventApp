//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Alikhan on 30.05.2022.
//

import UIKit
import SnapKit
 
final class EventDetailViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "NewYear") 
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let timeRemainingStackView = TimeRemainingStackView()
    
    var viewModel: EventDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelListener()
        
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    private func viewModelListener() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self, let timeRemainingViewModel = self.viewModel.timeRemainingViewModel else { return }
            self.backgroundImageView.image = self.viewModel.image
            self.timeRemainingStackView.update(with: timeRemainingViewModel)
        }
        
        viewModel.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        timeRemainingStackView.setup()
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(timeRemainingStackView)
    }
    
    private func setupLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        timeRemainingStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
