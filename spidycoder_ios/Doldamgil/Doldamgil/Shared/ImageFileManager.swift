//
//  ImageFileManager.swift
//  Doldamgil
//
//  Created by Kyle Yang on 2020/11/13.
//  Copyright © 2020 Kyle Yang. All rights reserved.
//

import UIKit

class ImageFileManager {
  static let shared: ImageFileManager = ImageFileManager()
// Save Image
// name: ImageName
  func saveImage(image: UIImage, name: String,
                 onSuccess: @escaping ((Bool) -> Void)) {
  guard let data: Data
    = image.jpegData(compressionQuality: 1)
      ?? image.pngData() else { return }
  if let directory: NSURL =
    try? FileManager.default.url(for: .documentDirectory,
                                 in: .userDomainMask,
                                 appropriateFor: nil,
                                 create: false) as NSURL {
      do {
        try data.write(to: directory.appendingPathComponent(name)!)
        onSuccess(true)
      } catch let error as NSError {
        print("Could not saveImage🥺: \(error), \(error.userInfo)")
        onSuccess(false)
      }
    }
  }
}
