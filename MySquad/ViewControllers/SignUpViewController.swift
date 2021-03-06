//
//  SignUpViewController.swift
//  MySquad
//
//  Created by Zach Barnett on 2/27/21.
//

import UIKit


class SignUpViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    let mySignUpModel = SignUpModel()
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        // validation
        self.mySignUpModel.setEmailAndPassword(email: emailAddressTextField.text!, password: passwordTextField.text!)
        let error = self.mySignUpModel.validateTextFields()
        
        if (error != nil){
            // Some error occurred, show error message.
            showError(error!)
        } else {
            let authError = self.mySignUpModel.FirebaseAuth()
            if (authError != nil){
                showError(authError!)
            } else {
                transitionToHome()
            }
        }
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
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
