//
//  AuthUtilities.swift
//  ClassOrganiser
//
//  Created by Deven Pile on 4/2/21.
//

import Foundation
import UIKit

class AuthUtilities{
    
    static func isPasswordValid(_ password : String) -> Bool {
            
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
    static func validateEmail(candidate: String) -> Bool {
     let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    static func validateFields(firstName:String, lastName:String, email:String, pass:String) -> String?{
        //Check for filled in
        if firstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastName.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || pass.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all fields"
        }
        //Check password
        
        let goodPass = pass.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(goodPass) == false {
            return "Password must be at least 8 characters, contain a number, and a special character"
        }
        //Check email
        
        let goodEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if validateEmail(candidate: goodEmail) == false {
            return "Please enter a valid email address"
        }
        
        return nil
    }
    
    static func validateFields(email:String, password:String) -> String?{
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please Fill in all fields"
        }
        let goodEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        if validateEmail(candidate: goodEmail) == false{
            return "Please enter a valid email addreess"
        }
        
        return nil
    }
}
