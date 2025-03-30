//
//  StaggeredView.swift
//  SwiftUI_MiniProject
//
//  Created by Bao Hoang on 30/3/25.
//

import SwiftUI

struct StaggeredView<Content: View>: View {
    var config: StaggeredConfig = .init()
    @ViewBuilder var content: Content
    
    var body: some View {
        Group(subviews: content) { collection in
            ForEach(collection.indices, id: \.self) { index in
                collection[index]
                    .transition(CustomStaggeredTransition(index: index, config: config))
            }
        }
    }
}

fileprivate struct CustomStaggeredTransition: Transition {
    var index: Int
    var config: StaggeredConfig
    func body(content: Content, phase: TransitionPhase) -> some View {
        let animationDelay: Double = min(Double(index) * config.delay, config.maxDelay)
        
        let didDisappear: Bool = phase == .didDisappear
        let x: CGFloat = config.offset.width
        let y: CGFloat = config.offset.height
        
        let reverseX: CGFloat = config.disappearInSameDirection ? x : -x
        let reverseY: CGFloat = config.disappearInSameDirection ? y : -y
        
        let disableX: CGFloat = config.noDisappearAnimation ? 0 : reverseX
        let disableY: CGFloat = config.noDisappearAnimation ? 0 : reverseY
        
        let offsetX = phase.isIdentity ? 0 : didDisappear ? disableX : x
        let offsetY = phase.isIdentity ? 0 : didDisappear ? disableY : y
        
        content
            .opacity(phase.isIdentity ? 1 : 0)
            .blur(radius: phase.isIdentity ? 0 : config.blurRadius)
            .compositingGroup()
            .scaleEffect(phase.isIdentity ? 1 : config.scale, anchor: config.scaleAnchor)
            .offset(x: offsetX, y: offsetY)
            .animation(config.animation.delay(animationDelay), value: phase)
    }
}

struct StaggeredConfig {
    var delay: Double = 0.03
    var maxDelay: Double = 0.2
    var blurRadius: CGFloat = 6
    var offset: CGSize = .init(width: 420, height: 0)
    var scale: CGFloat = 0.95
    var scaleAnchor: UnitPoint = .center
    var animation: Animation = .smooth(duration: 0.3, extraBounce: 0)
    var disappearInSameDirection: Bool = true
    var noDisappearAnimation: Bool = true
}

#Preview {
    ContentView()
}
