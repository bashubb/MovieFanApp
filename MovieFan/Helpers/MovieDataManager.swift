//
//  MovieDataManager.swift
//  MovieFan
//
//  Created by HubertMac on 25/06/2024.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: MovieDataManager, movies: [MovieModel])
    func didFailWithError(error: Error)
}

struct MovieDataManager {
     
    let urlString = "https://freetestapi.com/api/v1/movies?limit=5"
    
    var delegate: MovieManagerDelegate?
  
    func fetchMovies() {
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1.Create URL
        
        if let url = URL(string: urlString) {
            //2.Create a URLSession
            
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                guard let data else { return }
                if let movies = self.parseJSON(data) {
                    delegate?.didUpdateMovies(self, movies: movies)
                }
            }
        
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> [MovieModel]? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode([MovieData].self, from: movieData)
            
            var movies = [MovieModel]()
            for singleMovie in decodedData {
                let parsedMovie = MovieModel(
                    title: singleMovie.title,
                    poster: singleMovie.poster,
                    plot: singleMovie.plot,
                    actors: singleMovie.actors
                )
                movies.append(parsedMovie)
            }
            return movies
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
