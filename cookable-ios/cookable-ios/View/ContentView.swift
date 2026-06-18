//
//  ContentView.swift
//  cookable-ios
//
//  Created by Safa Auliya on 18/06/26.
//

import SwiftUI

struct ContentView: View {
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
                    Text("Turn the \(Text("Ingredients\n").foregroundColor(Color(red: 217/255, green: 210/255, blue: 165/255)))You Have into\n\(Text("Meals ").foregroundColor(Color(red: 26/255, green: 137/255, blue: 23/255)))You'll Love")
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

                }
                .glassEffect()
                .padding(.bottom, 32)
                .padding(.horizontal, 24)
                .frame(maxWidth: UIScreen.main.bounds.width * 1)
            }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (1, 1, 1, 1)
            }
            self.init(
                .sRGB,
                red: Double(r) / 255,
                green: Double(g) / 255,
                blue:  Double(b) / 255,
                opacity: Double(a) / 255
            )
        }
    }


#Preview {
    ContentView()
}
