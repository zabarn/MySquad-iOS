//
//  LoginModel.swift
//  MySquad
//
//  Created by Zach Barnett on 3/6/21.
//

import Foundation
import FirebaseAuth

class LoginModel{
    
    var cleanedEmail: String = ""
    var cleanedPassword: String = ""
    
    init(){
        
    }
    
    func setEmailAndPassword(email: String, password: String){
        self.cleanedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        self.cleanedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func validateTextFields() -> String? {
        if (self.cleanedEmail == "" || self.cleanedPassword == ""){
            return "Please enter both Email and Password."
        }
        if (isValidEmail(self.cleanedEmail) == false){
            return "The Email entered is not valid."
        }
        return nil
    }
    
    func FirebaseAuth() -> String? {
        var potentialError: String? = nil
        Auth.auth().signIn(withEmail: self.cleanedEmail, password: self.cleanedPassword) { (result, error) in
            if (error != nil){
                potentialError = error!.localizedDescription
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
