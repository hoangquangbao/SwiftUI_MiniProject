//
//  Card.swift
//  SwiftUI_MiniProject
//
//  Created by Bao Hoang on 13/4/25.
//

import Foundation

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var image: String
    var title: String
    var subtitle: String
    var description: String
}
