//
//  MovieData.swift
//  MovieFan
//
//  Created by HubertMac on 25/06/2024.
//

import Foundation

struct MovieData: Decodable  {
    
    let id: Int
    let title: String
    let year: Int
    let genre: [String]
    let rating: Float
    let director: String
    let actors: [String]
    let plot: String
    let poster: String
    let trailer: String
    let runtime: Int
    let awards: String
    let country: String
    let language: String
    let boxOffice: String
    let production: String
    let website: String
}

