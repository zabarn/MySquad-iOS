//
//  SignUpViewController.swift
//  MySquad
//
//  Created by Zach Barnett on 2/27/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    // Check if the fields are valid and that the data is correct. If so, return nil. Otherwise, return an error message as a string and place it in the error label.
    func validateTextFields() -> String? {
        
        // Check that both fields are filled in
        if ((emailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") || (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")){
            return "Please enter Email and Password."
        }
        // check if the password is at least 6 characters
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (cleanedPassword.count < 6){
            return "Please enter a password with at least 6 characters"
        }
        
        let cleanedEmail = emailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (isValidEmail(cleanedEmail) == false){
            return "The Email entered is not valid."
        }
        
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validation
        let error = validateTextFields()
        
        if (error != nil){
            // Some error occurred, show error message.
            showError(error!)
        } else {
            let email = emailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if (err != nil){
                // There is an error
                    self.showError("Error creating user")
                } else {
                    let database = Firestore.firestore()
                    
                    database.collection("users").addDocument(data: ["UID": result!.user.uid]) { (error) in
                        
                        if (error != nil){
                            // Show error message
                            self.showError("Error saving user data.")
                        }
                    }
                    // transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // from stackoverflow
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeUITabBarContoller
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
