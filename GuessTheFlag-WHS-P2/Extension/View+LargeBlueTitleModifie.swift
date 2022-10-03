//
//  CustomModifier.swift
//  GuessTheFlag-WHS-P2
//
//  Created by Ade Dwi Prayitno on 03/10/22.
//

import SwiftUI

struct LargeBluetitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitle() -> some View{
        modifier(LargeBluetitle())
    }
}
