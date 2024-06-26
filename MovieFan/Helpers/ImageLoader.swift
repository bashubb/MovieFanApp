//
//  ImageLoader.swift
//  MovieFan
//
//  Created by HubertMac on 25/06/2024.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data found")
                return
            }
            
            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
        task.resume()
    }
}
