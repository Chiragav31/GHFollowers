//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Shetty, Chirag Ranjit on 18/05/25.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView = UIView() //Its the white container box of the alert
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let bodyLabel = GFBodyLabel(textAlignment: .center)
    let actionButton = GFButton(backgroundColor: .systemRed, title: "Ok")
    
    var alertTitle: String?
    var alertDesc: String?
    var buttonTitle: String?
    
    
    init(title: String, alertDesc: String, buttonTitle: String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.alertDesc   = alertDesc
        self.buttonTitle = buttonTitle
        print(title, "chirag")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75) //This is how we get the blurry background when an alert box is called
        configureConatiner()
        configureTitleLabel()
        configureButton()
        configureDescLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureConatiner(){
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground //white in light mode and black in dark mode
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
        ])
    }
    
    func configureTitleLabel() {
        containerView.addSubview(titleLabel)//first we add the title sub view and then add the variable which holds the title text
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20), //pinning at the top of the containerview by 20 points
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), //20 from the left
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), //-20 from the right
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureButton() {
        containerView.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20), //pinning at the bottom of the containerview by -20 points
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), //20 from the left
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20), //-20 from the right
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc func dismissVC() {
        dismiss(animated: true) //This will just remove the pop up model and as you have set the target on self it will dismiss self which is the whole modal/page
    }
    
    func configureDescLabel() {
        containerView.addSubview(bodyLabel) //first we add the title sub view and then add the variable which holds the title text
        bodyLabel.text          = alertDesc ?? "Try again later"
        bodyLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8), //pinning at the top of the containerview by 20 points
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12), //pinning at the bottom of the containerview by -20 points
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20), //20 from the left
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20) //-20 from the right
        ])
    }
    
    

    

}
