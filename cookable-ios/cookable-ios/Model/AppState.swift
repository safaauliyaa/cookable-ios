//
//  AppState.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 22/06/26.
//

import Foundation
import Combine

@MainActor
final class AppState: ObservableObject {

    @Published var path: [AppRoute] = []
    @Published var currentIngredients: [Ingredient] = [] {
        didSet {
            saveIngredients()
        }
    }
    @Published private(set) var recipeResults: [Recipe] = []
    @Published private(set) var isSearchingRecipes = false

    init() {
        if let data = UserDefaults.standard.data(forKey: "currentIngredients"),
           let decoded = try? JSONDecoder().decode([Ingredient].self, from: data) {
            self._currentIngredients = Published(wrappedValue: decoded)
        }
    }

    private func saveIngredients() {
        if let encoded = try? JSONEncoder().encode(currentIngredients) {
            UserDefaults.standard.set(encoded, forKey: "currentIngredients")
        }
    }

    func showHome() {
        path = [.home]
    }

    func openRecipeDetail(_ recipe: Recipe) {
        path.append(.recipeDetail(recipe))
    }

    func returnToRecipeList() {
        guard path.last == .recipeList else {
            return
        }

        path = [.home, .recipeList]
    }

    func finishRecipeFlow() {
        path = [.home]
    }

    func addIngredient(_ ingredient: Ingredient) {
        guard !currentIngredients.contains(ingredient) else {
            return
        }

        currentIngredients.append(ingredient)
    }

    func removeIngredient(_ ingredient: Ingredient) {
        currentIngredients.removeAll {
            $0.id == ingredient.id
        }
    }

    func startRecipeSearch() {
        guard !currentIngredients.isEmpty, !isSearchingRecipes else {
            return
        }

        isSearchingRecipes = true
        recipeResults = []
        path = [.home, .waitingForRecipes]

//        Task {
//            async let recipes = RecipeRepository.searchRecipes(matching: currentIngredients)
//            async let minimumDelay: Void = waitForLoadingSplash()
//
//            let foundRecipes = await recipes
//            _ = await minimumDelay
//
//            recipeResults = foundRecipes
//            isSearchingRecipes = false
//            path = [.home, .recipeList]
//        }
        Task {
            async let recipes = RecipeRepository.searchRecipes(matching: currentIngredients)
            async let minimumDelay: Void = waitForLoadingSplash()

            let foundRecipes = await recipes

            print("Ingredients:", currentIngredients)
            print("Found recipes:", foundRecipes.count)

            _ = await minimumDelay

            recipeResults = foundRecipes
            isSearchingRecipes = false
            path = [.home, .recipeList]
        }
    }

    private func waitForLoadingSplash() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
    }
}

enum AppRoute: Hashable {
    case home
    case waitingForRecipes
    case recipeList
    case recipeDetail(Recipe)
}
