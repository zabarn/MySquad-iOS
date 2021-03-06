//
//  SignUpModel.swift
//  MySquad
//
//  Created by Zach Barnett on 3/6/21.
//

import Foundation
import FirebaseAuth
import Firebase
class SignUpModel{
    
    var cleanedEmail: String = ""
    var cleanedPassword: String = ""
    
    init(){
        
    }
    
    func setEmailAndPassword(email: String, password: String){
        self.cleanedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // Check if the fields are valid and that the data is correct. If so, return nil. Otherwise, return an error message as a string and place it in the error label.
    func validateTextFields() -> String? {
        
        // Check that both fields are filled in
        if (self.cleanedEmail == "" || self.cleanedPassword == ""){
            return "Please enter both Email and Password."
        }
        // check if the password is at least 6 characters
        if (self.cleanedPassword.count < 6){
            return "Please enter a password with at least 6 characters"
        }
        
        if (isValidEmail(self.cleanedEmail) == false){
            return "The Email entered is not valid."
        }
        
        return nil
    }
    
    func FirebaseAuth() -> String? {
        var potentialError: String? = nil
        // create user
        Auth.auth().createUser(withEmail: cleanedEmail, password: cleanedPassword) { (result, err) in
            if (err != nil){
            // There is an error
                potentialError = "Error creating user"
            } else {
                let database = Firestore.firestore()
                
                database.collection("users").addDocument(data: ["UID": result!.user.uid]) { (error) in
                    
                    if (error != nil){
                        // Show error message
                        potentialError = "Error saving user data."
                    }
                }
            }
        }
        return potentialError
    }
    
    
    // from stackoverflow
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
