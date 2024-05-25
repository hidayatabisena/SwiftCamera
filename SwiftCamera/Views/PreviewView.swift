//
//  PreviewView.swift
//  SwiftCamera
//
//  Created by Hidayat Abisena on 24/05/24.
//

import SwiftUI

struct PreviewView: View {
    @EnvironmentObject var model: CameraModel
    @State private var isRecording: Bool = false

    private let footerHeight: CGFloat = 110.0

    var body: some View {
        
        ImageView(image: model.previewImage )
//        Color.black
            .padding(.bottom, footerHeight)
            .overlay(alignment: .bottom) {
                buttonsView()
                    .frame(height: footerHeight)
                    .background(.gray.opacity(0.4))
            }
            .padding(.top, 40)
            .background(Color.black)

    }

    private func buttonsView() -> some View {
        GeometryReader { geometry in
            let frameHeight = geometry.size.height
            HStack {

                Button {
                    model.cameraMode.toggle()
                } label: {
                    Image(systemName: model.cameraMode == .photo ? "video.fill" : "camera.fill")

                }
                
                Spacer()

                if model.cameraMode == .photo {
                    Button {
                        model.camera.takePhoto()
                    } label: {
                        ZStack {
                            Circle()
                                .strokeBorder(.white, lineWidth: 3)
                                .frame(width: frameHeight, height:  frameHeight)
                            Circle()
                                .fill(.white)
                                .frame(width:  frameHeight-10, height: frameHeight-10)

                        }
                    }
                } else {
                    Button {
                        if isRecording {
                            isRecording = false
                            model.camera.stopRecordingVideo()
                        } else {
                            isRecording = true
                            model.camera.startRecordingVideo()
                        }
                    } label: {
                        if #available(iOS 17.0, *) {
                            Image(systemName: "record.circle")
                                .symbolEffect(.pulse, isActive: isRecording)
                                .foregroundStyle(isRecording ? Color.red : Color.white)
                                .font(.system(size: 50))
                        } else {
                            // Fallback on earlier versions
                            Image(systemName: "record.circle")
                                .foregroundColor(isRecording ? Color.red : Color.white)
                                .font(.system(size: 50))
                                .scaleEffect(isRecording ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isRecording)
                        }
                    }
                    
                }

                Spacer()

                Button {
                    model.camera.switchCaptureDevice()
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }

            }
            .font(.system(size: 28, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .padding(.vertical, 24)
        .padding(.bottom, 8)
        .padding(.horizontal, 32)

    }
}

#Preview {
    @StateObject var model = CameraModel()
//    model.photoToken = Image(systemName: "checkmark")

//    CameraView()
    return PreviewView()
        .environmentObject(model)
}
