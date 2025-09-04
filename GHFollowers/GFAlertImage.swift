//
//  GFAlertImage.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 28/07/25.
//

import UIKit

class GFAlertImage: UIImageView {
    
    let placeholderImage = UIImage(named:"avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius                        = 10
        image                                     = placeholderImage
        clipsToBounds                             = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from URLString:String) {
        
        let cacheKey = URLString as NSString  //the key is nothing but the avatar url and thats how we can identify each url and we need to cconvert the URLString to an NSSTring as the NSCache takes in a nsstring and not an ordinary urlstring
         
        if let image = cache.object(forKey: cacheKey) { //if we find the keys in cache then use it from the cache and dont run the rest of the function
            self.image = image
            return
        }
            
        
        guard let url = URL(string: URLString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            //STEP 1
            //So now we need to HANDLE ALL THESE OBJECTS
            //Now if an error exists then just return the error message
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else { return }
            
            guard let data = data else {return}
            
            guard let image = UIImage(data: data) else { return }
            
            //anytime we update UI, we need to do it on main thread
            
            self.cache.setObject(image, forKey: cacheKey as NSString) //assigning the data to the cache so once it gets downloaded it will be there in the cache
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
    
}
