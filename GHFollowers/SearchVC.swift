import UIKit


//3rd step 3.


class SearchVC: UIViewController {
    
    //So after you have created the induvidual components, first initialize them here to variables
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createTapExit()
        configureNavBar()
    }
    
    func createTapExit(){
        
        //tap on any place on the screen for the keyboard to dismiss and self here means searchVC
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))) //.endEditing method hides the keyboard when the user taps anywhere on the screen
        
        //UITapGestureRecognizer initializer takes two main inputs:
        //target: The object that will receive the action message when the gesture is recognized.
        //action: The selector (method) to call on the target when the gesture occurs.
        
        //next we add the gesture recogniser we just created
        view.addGestureRecognizer(tap)
    }
    
    var isusernameEntered: Bool {
        return !(usernameTextField.text!.isEmpty)
    }//This will return true if its not empty meaning it will only be returning true if the user has entered anything in the textField
    
    @objc func pushFollowersListVC() {
        guard isusernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username you want to search for", buttonTitle: "Ok")
            return
        }
    //*********Guard is like a sheild which does not let the rest of the code to be touched if the condition is not satisfied***************
        
        let followersListVC = FollowersListVC()
        followersListVC.title = usernameTextField.text // add the title of followersListVC screen
        followersListVC.username = usernameTextField.text
        navigationController?.pushViewController(followersListVC, animated:true) //we want to push the followerslistVc to the top of the view stack
            // A navigation controller manages the stack of view controllers in a hierarchy
    }
    
    //So we want a configuration for the nav bar for all the navigation controllers; SearchVC and FavouritesListVc (<Search, <Favourites)
    func configureNavBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = UIImage(named: "gh-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //basically an array of constraints for width, height etc
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80), //for the top most or the bottom most element we need to pin it to the top or bottom of the screen/view
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), //x axis
            logoImageView.heightAnchor.constraint(equalToConstant: 200), //height
            logoImageView.widthAnchor.constraint(equalToConstant: 200)   //width
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self //now we are listening to the text field
        //basically an array of constraints for width, height etc
        NSLayoutConstraint.activate([
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), //pinning it to the right and pinning it to the left of the view of space 50
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48), //as we are pinning it to the bottom of the logo
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), //pinning it to the right and pinning it to the left of the view of space 50
            usernameTextField.heightAnchor.constraint(equalToConstant: 50), //height -> any button should be moere than 48 points
        ])
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
        //basically an array of constraints for width, height etc
        NSLayoutConstraint.activate([
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50), //pinning it to the right and pinning it to the left of the view of space 50
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50), //pinning it to the right and pinning it to the left of the view of space 50
            callToActionButton.heightAnchor.constraint(equalToConstant: 50), //height -> any button should be moere than 48
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50), //for the top most or the bottom most element we need to pin it to the top or bottom of the screen/view
        ])
    }
    
}
    
    extension SearchVC: UITextFieldDelegate { //This means SearchVC is now following the UITextFieldDelegate protocol, which lets it react to text field events.
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool { //This function is automatically called when the user taps the "return" key on the keyboard while typing in the text field.
            pushFollowersListVC()
            return true
        }
    }

// a delegate is a design pattern that lets one object send messages or events to another object when something happens. It’s like saying, “Hey, if this event happens, I’ll let you (the delegate) know so you can decide what to do. So the usernameTextField sent the message to its delegate which is the searchVC. So when the user taps return on the keyboard, it will call the pushFollowersListVC function.
