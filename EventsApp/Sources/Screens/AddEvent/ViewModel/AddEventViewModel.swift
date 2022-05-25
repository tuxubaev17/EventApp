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
        case titleImage
    }
    
    private(set) var cells: [Cell] = []
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(
                TitleSubtitleCellViewModel.init(title: "Name", subTitle: "", placeholder: "Add a name")
            ),
            .titleSubtitle(TitleSubtitleCellViewModel.init(title: "Date", subTitle: "", placeholder: "Select a date"))
        ]
    
        onUpdate()
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
}
