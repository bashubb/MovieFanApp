

import Foundation

struct Movie: Comparable {
    
    let title: String
    let coverImageName: String
    let description: String
    var averageRating: Float
    
    static func < (lhs: Movie, rhs: Movie) -> Bool {
        (lhs.title == rhs.title)
        && (lhs.description == rhs.description)
        && (lhs.averageRating == rhs.averageRating)
    }
}

