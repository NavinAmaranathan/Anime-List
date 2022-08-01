//
//  AnimeResponse.swift
//  MVP
//
//  Created by Navi on 01/08/22.
//

import Foundation

struct AnimeResponse: Codable {
    let success: Bool
    let animeList: [Anime]
    
    enum CodingKeys: String, CodingKey {
        case success
        case animeList = "data"
    }
}

struct Anime: Codable {
    let animeID: Int
    let animeName: String
    let animeImg: String

    enum CodingKeys: String, CodingKey {
        case animeID = "anime_id"
        case animeName = "anime_name"
        case animeImg = "anime_img"
    }
}
