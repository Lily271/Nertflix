//
//  Movie.swift
//  Nertflix
//
//  Created by Lily Tran on 8/5/24.
//

import Foundation

struct TrendingTitleResponse: Codable {
    let results: [Title]
    
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

/*
 {
adult = 0;
"backdrop_path" = "/5cCfqeUH2f5Gnu7Lh9xepY9TB6x.jpg";
"genre_ids" =             (
 14,
 12,
 35
);
id = 967847;
"media_type" = movie;
"original_language" = en;
"original_title" = "Ghostbusters: Frozen Empire";
overview = "The Spengler family returns to where it all started \U2013 the iconic New York City firehouse \U2013 to team up with the original Ghostbusters, who've developed a top-secret research lab to take busting ghosts to the next level. But when the discovery of an ancient artifact unleashes an evil force, Ghostbusters new and old must join forces to protect their home and save the world from a second Ice Age.";
popularity = "468.881";
"poster_path" = "/e1J2oNzSBdou01sUvriVuoYp0pJ.jpg";
"release_date" = "2024-03-20";
title = "Ghostbusters: Frozen Empire";
video = 0;
"vote_average" = "6.533";
"vote_count" = 435;
 */
