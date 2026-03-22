//
//  HamburgerButton.swift
//  SaveGoalie
//
//

import SwiftUI

struct HamburgerButton: View {
    @Binding var isMenuShowing: Bool
    
    var body: some View {
        Button {
                withAnimation {
                    isMenuShowing.toggle()
                }
            } label: {
                Image(systemName: isMenuShowing ? "xmark" : "line.3.horizontal")
                    .font(.title2)
                    .frame(height: 22)
                    .foregroundColor(.primary)
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
            }
            .padding(.trailing)
            .padding(.top, 4)
    }
}

#Preview {
    @Previewable @State var isMenuShowing = false

    HamburgerButton(isMenuShowing: $isMenuShowing)
}
