//
//  TitleSubtitleCellViewModel.swift
//  EventsApp
//
//  Created by Alikhan on 25.05.2022.
//

import Foundation

final class TitleSubtitleCellViewModel {
    let title: String
    private(set) var subTitle: String
    let placeholder: String
    
    init(title: String, subTitle: String, placeholder: String) {
        self.title = title
        self.subTitle = subTitle
        self.placeholder = placeholder
    }
}
