//
//  FlagImage.swift
//  GuessTheFlag-WHS-P2
//
//  Created by Ade Dwi Prayitno on 03/10/22.
//

import SwiftUI

struct FlagImage: View {
    let image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 15)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(image : "UK")
    }
}
