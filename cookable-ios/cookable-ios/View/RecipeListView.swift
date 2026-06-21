//
//  RecipeListView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 21/06/26.
//

import SwiftUI

struct RecipeListView: View {
    @EnvironmentObject var appState: AppState
    
    // Optional parameter to inject recipes for previews
    var initialRecipes: [Recipe]? = nil

    private var recipesToDisplay: [Recipe] {
        if let initial = initialRecipes {
            return initial
        }
        return appState.recipeResults
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 248/255, green: 250/255, blue: 247/255)
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Here's what you\ncan cook!")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.primary)
                        .padding(.top, 80)
                        .padding(.bottom, 24)

                    LazyVStack(spacing: 20) {
                        ForEach(recipesToDisplay) { recipe in
                            NavigationLink(value: AppRoute.recipeDetail(recipe)) {
                                RecipeCardView(recipe: recipe)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
            
            VStack(spacing: 0) {
                HStack {
                    Button {
                        appState.path = [.home]
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(width: 48, height: 48)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
                    }
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
                .background(
                    Color(red: 248/255, green: 250/255, blue: 247/255)
                        .ignoresSafeArea(edges: .top)
                )
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    let base = Recipe.mock
    let mockRecipes = (1...4).map { index in
        Recipe(
            id: "mock-\(index)",
            title: "Omelette Broccoli Tomato",
            description: base.description,
            imageName: base.imageName,
            ingredients: base.ingredients,
            instructions: base.instructions
        )
    }
    return RecipeListView(initialRecipes: mockRecipes)
        .environmentObject(AppState())
}
