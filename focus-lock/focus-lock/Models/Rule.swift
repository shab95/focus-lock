//
//  Rule.swift
//  focus-lock
//
//  Created by Shabarish  on 1/17/26.
//

import Foundation

struct Rule: Identifiable, Hashable, Codable {
    var id: UUID = UUID()
    var title: String
    var isEnabled: Bool
    var createdAt: Date = Date()
}
