//
//  UIImageView+URL.swift
//  Countries
//
//  Created by Bengi Tunca on 8.10.2022.
//

import UIKit
import Kingfisher
import SVGKit

extension UIImageView {
    public func showImage(with url: URL) {
        kf.setImage(with: url,
                 options: [
                    .transition(ImageTransition.fade(0.5)),
                    .forceTransition,
                    .keepCurrentImageWhileLoading,
                    .processor(SVGImgProcessor())],
           progressBlock: nil)
    }
}

public struct SVGImgProcessor:ImageProcessor {
    public var identifier: String = "com.appidentifier.webpprocessor"
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            print("already an image")
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
