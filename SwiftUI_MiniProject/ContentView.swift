//
//  ContentView.swift
//  SwiftUI_MiniProject
//
//  Created by Bao Hoang on 30/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showView = false
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 12) {
                    Button {
                        self.showView.toggle()
                    } label: {
                        Text("Toggle View")
                            .foregroundStyle(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                            }
                    }
                    
                    let config = StaggeredConfig(
                        offset: .init(width: 0, height: 80),
                        scale: 0.85,
                        scaleAnchor: .center
                    )
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10) {
                        if self.showView {
                            StaggeredView(config: config) {
                                ForEach(1...10, id: \.self) { _ in
                                    dummyView2()
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(15)
            }
            .navigationTitle(Text("Staggered View"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func dummyView() -> some View {
        HStack(spacing: 10) {
            Circle()
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading, spacing: 0) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 10)
                    .padding(.trailing, 20)
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(height: 10)
                    .padding(.trailing, 140)
                
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 100, height: 10)
            }
        }
        .foregroundStyle(.gray.opacity(0.7).gradient)
    }
    
    private func dummyView2() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(.black.gradient)
            .frame(height: 150)
    }
}

#Preview {
    ContentView()
}
