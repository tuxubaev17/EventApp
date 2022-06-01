//
//  TitleSubtitleCellViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 25.05.2022.
//

import Foundation
import UIKit

final class TitleSubtitleCellViewModel {
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    private(set) var subTitle: String
    let placeholder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "dd.MM.yyyy"
        return date
    }()
    private(set) var image: UIImage?
    private(set) var onCellUpdate: VoidCallback?
    
    init(title: String, subTitle: String, placeholder: String, type: CellType, onCellUpdate: VoidCallback?) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    func update(_ subtitle: String) {
        self.subTitle = subtitle
    }
    
    func update(_ date: Date) {
        let stringData = dateFormatter.string(from: date)
        self.subTitle = stringData
        onCellUpdate?()
    }
    
    func update(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
