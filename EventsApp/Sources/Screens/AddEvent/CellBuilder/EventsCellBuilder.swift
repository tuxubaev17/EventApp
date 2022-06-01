//
//  EventsCellBuilder.swift
//  EventsApp
//
//  Created by Alikhan on 26.05.2022.
//

import Foundation

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: VoidCallback? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel.init(title: "Name", subTitle: "", placeholder: "Add a name...", type: .text, onCellUpdate: onCellUpdate)
        case .date:
            return TitleSubtitleCellViewModel.init(title: "Date", subTitle: "", placeholder: "Select a date...", type: .date, onCellUpdate: onCellUpdate)
        case .image:
            return TitleSubtitleCellViewModel.init(title: "Background", subTitle: "", placeholder: "", type: .image, onCellUpdate: onCellUpdate)
        }
    }
}

