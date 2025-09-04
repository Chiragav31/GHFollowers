//
//  User.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 23/06/25.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String  //converted from snake case to camel case
    var name: String?      //optional so wehen we parse the json if it is not there it will not crash the app and if its null we can handle it
    var location: String?
    var bio: String?
    var public_repos: Int
    var public_gists: Int
    var htmlUrl: String
    var following: Int
    var createdAt: String
}


//so now we have created two models -> User model and follower model
//we do models first when we make a network call we will have our objects done and now we can populate the UI from these objects
