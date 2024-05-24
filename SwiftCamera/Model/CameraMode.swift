//
//  CameraMode.swift
//  SwiftCamera
//
//  Created by Hidayat Abisena on 24/05/24.
//

import Foundation

enum CameraMode {
    case video
    case photo
}

extension CameraMode {
    mutating func toggle() {
        if self == .photo {
            self = .video
        } else {
            self = .photo
        }
    }
}
