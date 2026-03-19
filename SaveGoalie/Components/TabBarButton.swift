//
//  TabBarButton.swift
//  SaveGoalie
//
//

import SwiftUI

struct TabBarButton: View {
    let systemImageName: String
    let title: String
    let action: () -> Void
    
    // Below is just the basic body of whatever homeview on the app
    var body: some View {
        Button(action: action){
            VStack {
                Image(systemName: systemImageName)
                    .font(.title)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            .padding(.horizontal)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TabBarButton(
        systemImageName: "plus.circle.dashed",
        title: "New Goal",
        action: { }
    )
}
