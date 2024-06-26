//
//  MovieRatingManager.swift
//  MovieFan
//
//  Created by HubertMac on 25/06/2024.
//

import Foundation

class MovieRatingManager {
    static let shared = MovieRatingManager()
    
    private var ratings: [String: [Float]] = [:]
    
    private init() {
        loadRatings()
    }
    
    func rateMovie(_ movie: MovieModel, rating: Float) {
        var movieRatings = ratings[movie.title] ?? []
        movieRatings.append(rating)
        ratings[movie.title] = movieRatings
        saveRatings()
    }
    
    func getAverageRating(for movie: MovieModel) -> Float {
        guard let movieRatings = ratings[movie.title], !movieRatings.isEmpty else {
            return 0.0
        }
        let sum = movieRatings.reduce(0, +)
        return sum / Float(movieRatings.count)
    }
    
    private func saveRatings() {
        let defaults = UserDefaults.standard
        defaults.set(ratings, forKey: "movieRatings")
    }
    
    private func loadRatings() {
        let defaults = UserDefaults.standard
        ratings = defaults.dictionary(forKey: "movieRatings") as? [String: [Float]] ?? [:]
    }
}

