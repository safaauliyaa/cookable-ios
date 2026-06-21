//
//  ContentView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 18/06/26.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            Image(.boardingBg)
                .resizable()
                .scaledToFill()
                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                Spacer(minLength: 100)
                VStack {
                    Text("Cookable")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .shadow(radius: 5)
                }
                .padding()
                
                Spacer(minLength: 320)
                
                VStack(alignment: .leading, spacing: 12) {
//                    Text("Turn the \(Text("Ingredients\n").foregroundColor(Color(red: 217/255, green: 210/255, blue: 165/255)))You Have into\n\(Text("Meals ").foregroundColor(Color(red: 26/255, green: 137/255, blue: 23/255)))You'll Love")
//                        .foregroundColor(.white)
//                        .font(.largeTitle)
//                        .bold()
//                        .shadow(radius: 4)
                    Text("Cook Smarter\nWaste Less")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .shadow(radius: 4)
                    
                    Text("Transform the ingredients you already have into\n personalized meal ideas. Explore diverse recipes, reduce\n food waste, and make deciding what to cook effortless.")
                        .foregroundColor(.white)
                        .font(.caption)
                        .opacity(0.9)
                }
                .padding(.horizontal)
                
                Spacer()
                
                WhiteButtonView(
                    title: "Get Started"
                ) {
                    appState.showHome()
                }
                .glassEffect()
                .padding(.bottom, 32)
                .padding(.horizontal, 24)
                .frame(maxWidth: UIScreen.main.bounds.width * 1)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
