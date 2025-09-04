//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 23/06/25.
//

import UIKit

//So here we hit an API -> We get the JSON back -> Parse the JSON and turn it into objects -> We thrn use these objects to populate our UI

//This is a singleton (Its globally accessible) class which means we will have only one instance of this class throughout the app. This is useful for managing network requests, as we don't want to create multiple instances of the network manager.

class NetworkManager {
    static let shared = NetworkManager() //means every network manager will have this shared value
    let baseURL       = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()   //So NS is still referring to old ojbective C stuff. NS means next step. So it takes a key value pair
    
    private init() {}
        //this much of code creates our singleton
    
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?)-> Void) {
        //Fuction header explained -> S in this function where we pass our username to help build our URL to hit as we need to know few things like the username and page to hit the URL and get followers. Also we are using a completion handler which is a closure which returns either an array of followers or a nil with an error message and they are all optionals
        
        //A completion handler or a closure is a special function that you pass as a parameter to another function. It gets called when that function finishes its work
        
        //In your getFollowers function, the completion handler is the completed parameter. When the network call is done, completed is called with the results (followers or an error).
        
        //STEP 1
        //HERE WE CREATE OUR ENDPOINT
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        //STEP 2
        //Now if we DONT get a valid URL then return this error message
        guard let url = URL(string: endPoint) else {
            completed(nil, .invalidUsername)
            return
        }
    //************************GUARD*****************************
        
        print("URL TRIGGERED:", url)
        
        
        
        //STEP 3
        //Now if we get a valid URL we create a task where we create a URL session where we hit that API and we get back some attributes like response, data and an error etc
        //data, response, error  //.shared is a singleton
        //URLSession.shared.dataTask(with: url) -> This creates a data task that retrieves the contents of the specified URL. and when the  network request completes, it calls the completion handler with the data, response, and error.
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            //STEP 4
            //So now we need to HANDLE ALL THESE OBJECTS
            //Now if an error exists then just return the error message
            if let _ = error {
                completed(nil, .checkInternetConnection)
                return
            }
            
            //Now in this guard we are only going to move forward if the response is not nil and it has a response code is 200
            guard let httpResponse = response as? HTTPURLResponse, (httpResponse.statusCode == 200)
                    
            //response as? HTTPURLResponse -> Tries to convert the response object to an HTTPURLResponse which contains the status code information
            
           //as? is an operator which returns an optional value. If the conversion fails, it returns nil. if successful, it returns the converted value.
            
                else {
                completed(nil, .serverError)
                return
            }
            
            //Now to check if the data we recieved is not null
            guard let data = data else {
                completed(nil, .invalidServer)
                return
            }
            
            //Here we create a decoder where we want to decode the data we got and create an array of followers [as we get the data in the form of bytes]
            do {
                let decoder = JSONDecoder() //takes data from server and converts it into objects
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data) //compare the data format with the follower model and create an array of Follower from data
                completed(followers,nil)
                //if try (decoding fails)fails then catch will handle it instead of crashing the app
            } catch {
                completed(nil, .invalidServer)
            }
        }
        
        //THIS STARTS THE NETWORK CALL
        task.resume()
        
    }
}
