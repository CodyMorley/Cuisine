//
//  ImageCache.swift
//  Cuisine
//
//  Created by Cody Morley on 1/14/25.
//

import SwiftUI


class ImageCache {
    static private var store: [URL : Image] = [:]
    
    
    static subscript(url: URL) -> Image? {
        get { ImageCache.store[url] }
        set { ImageCache.store[url] = newValue }
    }
}
