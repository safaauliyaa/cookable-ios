//
//  HomePageView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 18/06/26.
//

import SwiftUI
import Foundation

struct Ingredient: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let category: String
    let emoji: String
}

struct HomePageView: View {
    @State private var showIngredientSheet = false
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    @State private var selectedIngredients: [Ingredient] = []
    @State private var animateCarrot = false
    @Namespace private var ingredientAnimation
    @State private var flyingIngredient: Ingredient?

    @State private var ingredients: [Ingredient] = []
    var filteredIngredients: [Ingredient] {

            if searchText.isEmpty {
                return Array(ingredients.prefix(20))
            }

            return ingredients.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Welcome to Cookable👋")
                    .font(.title3)

                Spacer()
                
                Button {
                    showIngredientSheet = true
                } label: {
                    ZStack {

                        Image(systemName: "carrot.fill")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 48)
                            .background(selectedIngredients.isEmpty
                                        ? Color.black
                                        : Color.cookableGreen)
                            .animation(
                                .easeInOut(duration: 0.2),
                                value: selectedIngredients.count
                            )
                            .clipShape(Circle())
                            .scaleEffect(animateCarrot ? 1.2 : 1.0)

                        if !selectedIngredients.isEmpty {

                            Text("\(selectedIngredients.count)")
                                .font(.caption2.bold())
                                .foregroundStyle(.white)
                                .frame(width: 18, height: 18)
                                .background(.red)
                                .clipShape(Circle())
                                .offset(x: 16, y: -16)
                                .transition(.scale)
                        }
                    }
                    .animation(
                        .spring(),
                        value: selectedIngredients.count
                    )
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)

            if isSearchFocused {
                Spacer()
                    .frame(height: 16)
            } else {
                Spacer()
            }

            Text("What ingredients do you\nhave today?")
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)
                

            VStack(spacing: 16) {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField(
                        "Search and add ingredients...",
                        text: $searchText
                    )
                    .focused($isSearchFocused)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.gray.opacity(0.4))
                )

                if isSearchFocused {
                    ScrollView {
                        FlowLayout {
                            ForEach(filteredIngredients) { ingredient in
                                Button {
                                    if !selectedIngredients.contains(ingredient) {
                                        if !selectedIngredients.contains(ingredient) {

                                            selectedIngredients.append(ingredient)

                                            withAnimation(
                                                .spring(
                                                    response: 0.3,
                                                    dampingFraction: 0.4
                                                )
                                            ) {
                                                animateCarrot = true
                                            }

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {

                                                withAnimation(.spring()) {
                                                    animateCarrot = false
                                                }

                                            }
                                        }
                                    }
                                } label: {
                                    Text(ingredient.name)
                                        .font(.caption)
                                        .foregroundStyle(
                                            selectedIngredients.contains(ingredient)
                                                ? Color.white
                                                : Color.black
                                        )
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(
                                            selectedIngredients.contains(ingredient)
                                                ? Color.cookableGreen
                                                : Color.white
                                        )
                                        .overlay {
                                            Capsule()
                                                .stroke(
                                                    selectedIngredients.contains(ingredient)
                                                        ? Color.cookableGreen
                                                        : Color.black.opacity(0.4)
                                                )
                                        }
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    .transition(.opacity)
                }
            }
            .padding(.horizontal, 24)

            if !isSearchFocused {
                Spacer()
                Spacer()
            }
        }
        .animation(.easeInOut, value: isSearchFocused)
        .onAppear {
            ingredients = IngredientRepository.loadIngredients()
        }
        .sheet(isPresented: $showIngredientSheet) {
            IngredientInfoSheet(
                selectedIngredients: $selectedIngredients
            )
                .presentationDetents([.medium, .large])
        }
    }
}


#Preview {
    HomePageView()
}
