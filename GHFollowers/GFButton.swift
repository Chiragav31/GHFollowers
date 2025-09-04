//
//  1. GFButton.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 11/05/25.
//

import UIKit

class GFButton: UIButton {
    //as we are doing some custom configurtion of this UI button, we need to override the initialiser
    override init(frame: CGRect) {
        //first we make sure all what apple built in the normal UI button will be called first
        super.init(frame: frame)
            //Now we start the custom configuration -> <so basically override the init and later super.init>
        configure()
    }
    
    //code added by "Fix"
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //A button will mainly have a bg color and a title to say what the button does
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero) //as we using auto layput anyway and dont need to set any height width here so .zero also on top we are not passing frame as a param for the init
        //self means this GFButton bg color will be what is passed in the function
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal) //there are different states for a button, normal is the default state, ex press etc
        configure()
    }
    
    //basic custom configuration
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false //it does auto layout
    }
    
}


