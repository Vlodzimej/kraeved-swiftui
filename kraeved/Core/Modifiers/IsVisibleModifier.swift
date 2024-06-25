//
//  isVisible.swift
//  kraeved
//
//  Created by Владимир Амелькин on 26.06.2024.
//
import SwiftUI

struct IsVisibleModifier : ViewModifier {
    
     var isVisible : Bool
    // the transition will add a custom animation while displaying the
    // view.
    var transition : AnyTransition

    func body(content: Content) -> some View {
        ZStack{
            if isVisible{
                content
                    .transition(transition)
            }
        }
    }
}
extension View {
    
    func isVisible(isVisible: Bool, transition: AnyTransition = .scale) -> some View{
        modifier(
            IsVisibleModifier(
                isVisible: isVisible,
                transition: transition
            )
        )
    }
}
