//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 27/06/25.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername = "This username created an invalid request. Please try again later."
    case checkInternetConnection = "Unable to complete your request. Please check your internet connection"
    case serverError = "No response from the server. Please try again."
    case invalidServer = "The data received from the server is invalid."
}
