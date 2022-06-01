//
//  UIView+Extensions.swift
//  EventsApp
//
//  Created by Alikhan on 27.05.2022.
//

import UIKit

enum Edge {
    case left
    case right
    case top
    case bottom
}

extension UIView {
    func pinToSuperView(_ edges: [Edge] = [.top, .left, .right, .bottom], constant: CGFloat = 0) {
        guard let superView = superview else { return }
        edges.forEach { type in
            switch type {
            case .top:
                topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superView.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
