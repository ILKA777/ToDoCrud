//
//  BlankView.swift
//  ToDoCRUD
//
//  Created by Илья on 04.02.2024.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        Color.black
            .opacity(0.5)
            .ignoresSafeArea()
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
