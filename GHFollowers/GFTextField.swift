//
//  2. GFTextField.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 11/05/25.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) { //so this function gets called first when you call GFTextField() in the code
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius        = 8
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.systemGray.cgColor
        
        textColor                 = .label //LABEL IS THE TYPE OF COLOR applied to the text entered into the field
        tintColor                 = .label //Its the blinker color
        font                      = UIFont.preferredFont(forTextStyle: .title2)  //Title 2 is a bt larger
        adjustsFontSizeToFitWidth = true //if someone has a really big username the name will shrink to fit the textfield
        placeholder               = "Search for username..."
        backgroundColor           = .tertiarySystemBackground
        autocorrectionType        = .no
        returnKeyType             = .go
        keyboardType              = .default
        textAlignment             = .center
    }
}
