//
//  ViewController.swift
//  MySquad
//
//  Created by Zach Barnett on 2/27/21.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    let myLoginModel = LoginModel()
    
    @IBAction func loginTapped(_ sender: Any) {
        // Make sure fields are filled correctly
        self.myLoginModel.setEmailAndPassword(email: emailAddressTextField.text!, password: passwordTextField.text!)
        let error = myLoginModel.validateTextFields()
        
        if (error != nil){
            // Some error occurred, show error message.
            showError(error!)
        } else {
            let authError = self.myLoginModel.FirebaseAuth()
            if (authError != nil){
                showError(authError!)
            } else {
                transitionToHome()
            }
        }
        
    }
    func transitionToHome(){
        self.performSegue(withIdentifier: "LoginToTabBar", sender: nil)
    }
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

