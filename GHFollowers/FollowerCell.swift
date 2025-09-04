//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 28/07/25.
//

import UIKit

class FollowerCell: UICollectionViewCell{
    
    static let followerCellId = "followerCellId"
    
    var avatarImageView = GFAlertImage(frame: .zero) //as we are adjusting via constraints
    var username = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower)
    {
        username.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(username)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            username.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            username.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            username.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            username.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
