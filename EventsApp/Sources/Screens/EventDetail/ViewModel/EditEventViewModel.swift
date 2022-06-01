//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 31.05.2022.
//

import UIKit

final class EditEventViewModel {
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    var onUpdate: VoidCallback?
    private(set) var cells: [Cell] = []
    weak var coordinator: EditEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    private let coreDataManager: CoreDataManager
    private let cellBuider: EventsCellBuilder
    private let event: Event
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    
    init(event: Event, cellBuider: EventsCellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.cellBuider = cellBuider
        self.coreDataManager = coreDataManager
        self.event = event
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subTitle, let dateString = dateCellViewModel?.subTitle, let image = backgroundImageCellViewModel?.image, let date = dateFormatter.date(from: dateString) else { return }
        coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else { return }
            coordinator?.showImagePicker(completion: { image in
                titleSubtitleCellViewModel.update(image)
            })
        }
    }
}

extension EditEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuider.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuider.makeTitleSubtitleCellViewModel(.date, onCellUpdate: { [weak self] in
            self?.onUpdate?()
        })
        backgroundImageCellViewModel = cellBuider.makeTitleSubtitleCellViewModel(.image, onCellUpdate: { [weak self] in
            self?.onUpdate?()
        })
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel  else { return }
        
        cells = [
            .titleSubtitle(
               nameCellViewModel
            ),
            .titleSubtitle(
                dateCellViewModel
            ),
            .titleSubtitle(
                backgroundImageCellViewModel
            )
        ]
        
        guard let name = event.name,
                let date = event.date,
                let imageData = event.image,
                let image = UIImage(data: imageData)
        else { return }
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundImageCellViewModel.update(image)
    }
}

