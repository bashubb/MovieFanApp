

import Foundation

struct MovieModel: Comparable {
    
    let title: String
    let coverImageName: String
    let description: String
    
    func averageRating() -> Float {
        MovieRatingManager.shared.getAverageRating(for: self)
    }
    
    static func < (lhs: MovieModel, rhs: MovieModel) -> Bool {
        (lhs.title == rhs.title)
        && (lhs.description == rhs.description)
    }
    
}

