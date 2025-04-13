//
//  ContentView.swift
//  SwiftUI_MiniProject
//
//  Created by Bao Hoang on 30/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading: Bool = false
    @State private var card: Card?
    
    var body: some View {
        VStack {
            SomeCardView(card: card)
                .onTapGesture {
                    withAnimation(.smooth) {
                        if card == nil {
                            card = .init(image: "fireworks", title: "Title", subtitle: "Subtitle", description: "Description")
                        } else {
                            card = nil
                        }
                    }
                }
            
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }
}

struct SomeCardView: View {
    var card: Card?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Rectangle()
                .foregroundStyle(.clear)
                .overlay {
                    if let card {
                        Image(systemName: card.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        SkeletonView(.rect)
                    }
                }
                .frame(height: 220)
                .clipped()
            
            VStack(alignment: .leading, spacing: 6) {
                if let card {
                    Text(card.title)
                        .fontWeight(.semibold)
                } else {
                    SkeletonView(.rect(cornerRadius: 5))
                        .frame(height: 20)
                }
                
                Group {
                    if let card {
                        Text(card.subtitle)
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    } else {
                        SkeletonView(.rect(cornerRadius: 5))
                            .frame(height: 20)
                    }
                }
                .padding(.trailing)
                
                ZStack {
                    if let card {
                        Text(card.description)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    } else {
                        SkeletonView(.rect(cornerRadius: 5))
                    }
                }
                .frame(height: 50)
                .lineLimit(3)
            }
            .padding([.horizontal, .top], 15)
            .padding(.bottom, 25)
        }
        .background(.background)
        .clipShape(.rect(cornerRadius: 15))
        .shadow(color: .black.opacity(0.1), radius: 10)
    }
}

#Preview {
    ContentView()
}
