//
//  ViewController.swift
//  MySquad
//
//  Created by Zach Barnett on 2/27/21.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func loginTapped(_ sender: Any) {
        // Make sure fields are filled correctly
        let error = validateTextFields()
        
        if (error != nil){
            // Some error occurred, show error message.
            showError(error!)
        } else {
            let email = emailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if (error != nil){
                    self.showError(error!.localizedDescription)
                } else {
                    self.transitionToHome()
                }
            }
        }
        
    }
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeUITabBarContoller
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
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
    func validateTextFields() -> String? {
        if ((emailAddressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "") || (passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")){
            return "Please enter Email and Password."
        }
        let cleanedEmail = emailAddressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if (isValidEmail(cleanedEmail) == false){
            return "The Email entered is not valid."
        }
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

