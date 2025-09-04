//
//  Follower.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 23/06/25.
//

import Foundation

//building our model for our follower api

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String  //converted from snake case to camel case from json
}
