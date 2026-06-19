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
}

struct HomePageView: View {
    @State private var showIngredientSheet = false
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool

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
                    Image(systemName: "carrot.fill")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .background(.black)
                        .clipShape(Circle())
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

                                } label: {
                                    Text(ingredient.name)
                                        .font(.caption)
                                        .foregroundStyle(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(.white)
                                        .overlay {
                                            Capsule()
                                                .stroke(.black.opacity(0.4))
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
            IngredientInfoSheet()
                .presentationDetents([.medium, .large])
        }
    }
}


#Preview {
    HomePageView()
}
