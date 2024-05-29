//
//  YoutubeSearchResponse.swift
//  Nertflix
//
//  Created by Lily Tran on 17/5/24.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
