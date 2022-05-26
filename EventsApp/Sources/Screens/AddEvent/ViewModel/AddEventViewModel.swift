//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 24.05.2022.
//

import Foundation

final class AddEventViewModel {
    
    var onUpdate: () -> () = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(
                TitleSubtitleCellViewModel.init(title: "Name", subTitle: "", placeholder: "Add a name...", type: .text, onCellUpdate: {})
            ),
            .titleSubtitle(TitleSubtitleCellViewModel.init(title: "Date", subTitle: "", placeholder: "Select a date...", type: .date, onCellUpdate: { [weak self] in
                self?.onUpdate()
            })),
            .titleSubtitle(TitleSubtitleCellViewModel.init(title: "Background", subTitle: "", placeholder: "", type: .image, onCellUpdate: { [weak self] in
                self?.onUpdate()
            }))
        ]
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        coordinator?.dissmisToEventPage()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
}
