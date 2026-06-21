//
//  InstructionsDetail.swift
//  cookable-ios
//
//  Created by Safa Auliya Hidayat on 21/06/26.
//

import SwiftUI

struct InstructionsDetail: View {

    let recipe: Recipe

    @State private var isExpanded = true

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            Button {
                withAnimation(.easeInOut) {
                    isExpanded.toggle()
                }

            } label: {

                HStack {

                    Text("Instructions")
                        .font(.title3.bold())

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption.bold())
                        .foregroundStyle(.secondary)
                        .rotationEffect(
                            .degrees(isExpanded ? 90 : 0)
                        )
                }
            }
            .buttonStyle(.plain)

            if isExpanded {
                VStack (alignment: .leading, spacing: 20){
                    ForEach(
                        Array(recipe.instructions.enumerated()),
                        id: \.offset
                    ) { index, instruction in

                        HStack(alignment: .center, spacing: 16) {

                            Text("\(index + 1)")
                                .font(.caption.bold())
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.cookableGreen)
                                .clipShape(Circle())

                            Text(instruction)
                                .font(.body)

                            Spacer()
                        }
                }
                
                }
                .padding(.bottom, 4)
            }

            Divider()
                .frame(height: 2)
                .background(
                    Color.black.opacity(0.15)
                )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
    }
}

#Preview {
    InstructionsDetail(recipe: .mock)
}
