//
//  BottomTabBar.swift
//  SaveGoalie
//
//


import SwiftUI

struct BottomTabBar: View {
    @Binding var selectedTab: Int
    @Binding var isSavignsGoalViewShowing: Bool
    
    var body: some View {
        ZStack {
            UnevenRoundedRectangle(topLeadingRadius: 0,
                                   bottomLeadingRadius: 42,
                                   bottomTrailingRadius: 42,
                                   topTrailingRadius: 0,
                                   style: .continuous)
            .fill(.regularMaterial)
            
            HStack {
                TabBarButton(systemImageName: "dollarsign.bank.building.fill", title: "Goals"){
                    selectedTab = 0
                }
                
                UnevenRoundedRectangle(topLeadingRadius: 0,
                                       bottomLeadingRadius: 100,
                                       bottomTrailingRadius: 100,
                                       topTrailingRadius: 0,
                                       style: .continuous)
                .fill(Color(.systemBackground))
                .frame(width: 75)
                .padding([.leading, .trailing, .bottom])
                .padding(.bottom, 5)
                .overlay(alignment: .top) {
                    Button {
                        isSavignsGoalViewShowing.toggle()
                    } label: {
                        Image(systemName: "plus.circle.dashed")
                            .font(.system(size: 55))
                    }
                    .offset(y: -20)
                }
                
                TabBarButton(systemImageName: "scroll.fill", title: "History"){
                    selectedTab = 1
                }
            }
        }
        .frame(height: 70)
    }
}

#Preview (traits: .sizeThatFitsLayout) {
    BottomTabBar(selectedTab: .constant(0), isSavignsGoalViewShowing: .constant(false))
        .padding()
}
