//
//  Recipe.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 21/06/26.
//

import Foundation

struct Recipe: Codable, Identifiable {

    let id: String

    let title: String
    let description: String

    let imageName: String

    let ingredients: [RecipeIngredient]

    let instructions: [String]
}

struct RecipeIngredient: Codable, Identifiable {

    let id: String

    let name: String

    let amount: String?
}


