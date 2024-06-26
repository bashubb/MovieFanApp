

import UIKit

struct MovieModel: Comparable {
    let title: String
    let poster: String
    let plot: String
    let actors: [String]
    
    var moviePoster: UIImageView {
        let imageView = UIImageView()
        
        if let imageURL = URL(string: poster) {
            imageView.loadImage(from: imageURL)
        }
        return imageView
    }
    
    var averageRating: Float {
        MovieRatingManager.shared.getAverageRating(for: self)
    }
    
    static func < (lhs: MovieModel, rhs: MovieModel) -> Bool {
        (lhs.title == rhs.title)
        && (lhs.poster == rhs.poster)
    }
    
}

