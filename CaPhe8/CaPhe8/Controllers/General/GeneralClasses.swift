//
//  GeneralClasses.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/08/17.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import Foundation
import UIKit
//
// UITextView text Validation
//
class Validation: NSObject {
    //for failure and success results
    enum Alert {
        case success
        case failure
        case error
    }
    //for success or failure of validation with alert message
    enum Valid {
        case success
        case failure
    }
    /*:
     *. Validation type:Enum
     */
    enum ValidationType {
        //: Email
        case email
        //: String have first letter uppercase
        case stringWithFirstLetterCaps
        //: Phone Number
        case phoneNo
        //: Standard string
        case alphabeticString
        //: Password
        case password
        //: Confirm password
        case confirmPassword
    }
    /*:
     *. RegEx String
     */
    enum RegEx: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" // Email
        case password = "^.{6,15}$" // Password length 6-15
        case alphabeticStringWithSpace = "^[a-zA-Z ]{3,30}$" // e.g. hello sandeep
        case alphabeticStringFirstLetterCaps = "^[A-Z]+[a-zA-Z]*$" // SandsHell
        case phoneNo = "[0-9]{10,14}" // PhoneNo 10-14 Digits        //Change RegEx according to your Requirement
    }
    /*:
     *. Alert Message
     */
    enum AlertMessages: String {
        case inValidEmail = "Invalid Email"
        case invalidFirstLetterCaps = "First Letter should be capital"
        case inValidPhone = "Invalid Phone"
        case invalidAlphabeticString = "Invalid String"
        case inValidPSW = "Invalid Password"
        
        case emptyPhone = "Empty Phone"
        case emptyEmail = "Empty Email"
        case emptyFirstLetterCaps = "Empty Name"
        case emptyAlphabeticString = "Empty String"
        case emptyPSW = "Empty Password"
        case comparePasswordFail = "Password do not match"
        
        func localized() -> String {
            return NSLocalizedString(self.rawValue, comment: "")
        }
    }
    // static property
    public static let shared = Validation();
    
    /*:
     *. - Validate text
     *. - Parameters:
     *.     - values:
     *.         - type:ValidationType kiểu validate ví dụ như email, text, hoặc phone
     *.         - inputValue:String value validate
     */
    func Validate(values: (type: ValidationType, inputValue: String)...)-> Valid{
        for valueToBeChecked in values {
            switch valueToBeChecked.type {
            //: email
            case .email:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .email, .emptyEmail, .inValidEmail)) {
                    return tempValue
                }
            //: string with first letter cap
            case .stringWithFirstLetterCaps:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .alphabeticStringFirstLetterCaps, .emptyFirstLetterCaps, .invalidFirstLetterCaps)) {
                    return tempValue
                }
            //: phone number
            case .phoneNo:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .phoneNo, .emptyPhone, .inValidPhone)) {
                    return tempValue
                }
            //: alphabetic string
            case .alphabeticString:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .alphabeticStringWithSpace, .emptyAlphabeticString, .invalidAlphabeticString)) {
                    return tempValue
                }
            //: password
            case .password,
                 .confirmPassword:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .password, .emptyPSW, .inValidPSW)) {
                    return tempValue
                }
            }
        }
        return .success
    }
    /*:
     *.
     */
    func isValidString(_ input: (text: String, regex: RegEx, emptyAlert: AlertMessages, invalidAlert: AlertMessages)) -> Valid? {
        if input.text.isEmpty {
            return .failure
        } else if isValidRegEx(input.text, input.regex) != true {
            return .failure
        }
        return nil
    }
    
    func isValidRegEx(_ testStr: String, _ regex: RegEx) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
        let result = stringTest.evaluate(with: testStr)
        return result
    }
    /*:
     *. - Get validated result in bool type
     *. - Parameters:
     *.     - validated:Valid result type
     *. - Returns:
     *.     - true: Valid.success
     *.     - false: Valid.failure
     */
    func GetBoolTypeByValidateResults( validated : Valid )->Bool{
        if(validated == Valid.success){
            return true
        }else{
            return false
        }
    }
    /*:
     *. - Validate Text
     *. - Parameters:
     *.     - validateType:ValidationType validate type
     *.     - textField:UITextField UI Text Field, get text and set border if wrong
     *.     - error:UILabel UI Label, show error message when wrong validate
     *.     - alertMessgae:AlertMessages error message
     *. - Returns:
     *.     - None
     */
    func ValidateText( validateType : ValidationType,
                       textField : UITextField,
                       error : UILabel,
                       alertMessgae: Validation.AlertMessages,
                       compareTextField : UITextField? = nil ){
        // text
        let text: String? = textField.text ?? nil
        // response
        var response = Validate(values: (validateType , text! ));
        // alert message if fail
        var failMessage = alertMessgae
        //: Common Border Color
        let BorderColor : UIColor = UIColor(red: 243 / 255, green: 178 / 255, blue: 189 / 255, alpha: 1.0)
        
        // Check if it different compare Text
        if(compareTextField != nil){
            let compareText: String? = compareTextField?.text ?? nil
            if(compareText != text ){
                response = Valid.failure
                failMessage = .comparePasswordFail
            }
        }
        // Check response
        if(response == Valid.success){
            // If success
            textField.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
            error.text = "";
        }else{
            // If fail
            textField.layer.addBorder( edge: UIRectEdge.bottom , color: .red, thickness: 1.0)
            error.text = failMessage.rawValue
        }
    }
}
