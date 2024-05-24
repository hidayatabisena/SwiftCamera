//
//  CameraView.swift
//  SwiftCamera
//
//  Created by Hidayat Abisena on 24/05/24.
//

import SwiftUI

struct CameraView: View {
    @StateObject private var model = CameraModel()

    var body: some View {

        ZStack {
            if let _ = model.photoToken {
                SaveImageView()
            } else if let _ = model.movieFileUrl {
                SaveVideoView()
            } else {
                PreviewView()
                    .onAppear {
                        model.camera.isPreviewPaused = false
                    }
                    .onDisappear {
                        model.camera.isPreviewPaused = true
                    }
            }

        }
        .task {
            await model.camera.start()
        }
        .ignoresSafeArea(.all)
        .environmentObject(model)
    }
}


#Preview {
    @StateObject var model = CameraModel()
//    model.photoToken = Image(systemName: "checkmark")

//    CameraView()
    return SaveImageView()
        .environmentObject(model)

}
