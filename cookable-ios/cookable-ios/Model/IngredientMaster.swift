//
//  IngredientMaster.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 21/06/26.
//

import Foundation

struct Ingredient: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let category: String
    let emoji: String
}

struct IngredientMaster: Codable, Identifiable {
    let id: String
    let name: String
    let category: String
    let emoji: String
}
