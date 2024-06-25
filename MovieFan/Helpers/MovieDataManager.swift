//
//  MovieDataManager.swift
//  MovieFan
//
//  Created by HubertMac on 25/06/2024.
//

import Foundation

protocol MovieManagerDelegate {
    func didUpdateMovies(_ movieManager: MovieManager, movie: MovieModel)
    func didFailWithError(error: Error)
}

struct MovieManager {
     
    let urlString = "https://freetestapi.com/api/v1/movies?limit=5"
    
    var delegate: MovieManagerDelegate?
  
    
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
                
                if let movie = self.parseJSON(data) {
                    delegate?.didUpdateMovies(self, movie: movie)
                }
                
            }
        
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ movieData: Data) -> MovieModel? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let name = decodedData.name
            
//            return WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return MovieModel(title: "", coverImageName: "", description: "")
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
