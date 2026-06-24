//
//  AppRootView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 22/06/26.
//

import SwiftUI

struct AppRootView: View {

    @StateObject private var appState = AppState()
    @State private var isShowingSplash = true

    var body: some View {
        Group {
            if isShowingSplash {
                CookableView()
                    .task {
                        try? await Task.sleep(nanoseconds: 1_500_000_000)

                        withAnimation(.easeInOut(duration: 0.9)) {
                            isShowingSplash = false
                        }
                    }
            } else {
                NavigationStack(path: $appState.path) {
                    ContentView()
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .home:
                                HomePageView()

                            case .waitingForRecipes:
                                WaitforRecipeView()

                            case .recipeList:
                                RecipeListView()

                            case .recipeDetail(let recipe):
                                DetailRecipeView(recipe: recipe)
                            }
                        }
                }
            }
        }
        .environmentObject(appState)
    }
}

#Preview {
    AppRootView()
}
