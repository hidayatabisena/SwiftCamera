//
//  CameraView.swift
//  SwiftCamera
//
//  Created by Hidayat Abisena on 24/05/24.
//

import SwiftUI

struct CameraView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    CameraView()
}
