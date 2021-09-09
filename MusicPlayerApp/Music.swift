//
//  Result.swift
//  Result
//
//  Created by Mila on 08/09/21.
//

import Foundation

struct Music: Decodable {
    var artistName: String?
    var trackName: String?
    var previewUrl: String?
    var collectionName: String?
    var artworkUrl60: String?
    
    private enum CodingKeys: String, CodingKey {
        case artistName
        case trackName
        case previewUrl
        case collectionName
        case artworkUrl60
    }
}
