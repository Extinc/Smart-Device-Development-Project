//
//  WorkoutImageDataManager.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 10/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import SDWebImage

class WorkoutImageDataManager: NSObject {
    static func prefetchImage(exercise: [Exercise]){
        var imageUrls: [URL] = []
        for i in exercise {
            for k in i.imageLink {
                if let url = URL.init(string: k) {
                    imageUrls.append(url)
                }
            }
        }
        
        SDWebImagePrefetcher.shared().prefetchURLs(imageUrls, progress: nil, completed: { finishedCount, skippedCount in
            print("Prefetch complete!")
        })
    }
}
