//
//  HamburgerOverlay.swift
//  SaveGoalie
//
//
import SwiftUI

struct HamburgerOverlay: View {
    @Binding var isMenuShowing: Bool
    @Binding var isProfileShowing: Bool
    @Binding var isSettingsShowing: Bool

    var body: some View {
        Color.black.opacity(0.3)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    isMenuShowing = false
                }
            }
            .overlay {
                VStack(spacing: 20) {
                    Button {
                        isMenuShowing.toggle()
                        isProfileShowing.toggle()
                    } label: {
                        Label("Profile", systemImage: "person.circle")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }

                    Button {
                        isMenuShowing.toggle()
                        isSettingsShowing.toggle()
                    } label: {
                        Label("Settings", systemImage: "gearshape")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                }
                .padding(32)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20))
                .transition(.scale.combined(with: .opacity))
            }
    }
}

#Preview {
    Color.clear
        .overlay {
            HamburgerOverlay(isMenuShowing: .constant(true), isProfileShowing: .constant(false), isSettingsShowing: .constant(false))
        }
}
