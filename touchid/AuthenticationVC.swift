//
//  AuthenticationVC.swift
//  touchid
//
//  Created by Kristina Dev on 1/27/17.
//  Copyright © 2017 Kristina Dev. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationVC: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //Connecting our button with Action
    @IBAction func useTouchIdButtonTapped(_ sender: Any)
    {
        let authenticationcontext = LAContext()
        var error: NSError?
        
        if authenticationcontext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        {
        //TouchID, navigation to the success VC, and handling errors
            authenticationcontext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Only Humans Allowed. Sorry no Aliens. 👽 ", reply: {(success, error) in
                
                if success
                {
                    //Navigate to Success View Controller
                    self.navigateToAuthenticatedVC()
                }
                else
                {
                    if let error = error as? NSError
                    {
                        //Display Error
                        let message = self.errorMessageForLAErrorCode(errorCode: error.code)
                        self.showAlertViewAfterEvaluationPolicyWithMessage(message: message)
                    }
                }
            })
        }
        else
        {
            showAlertViewForNoBiometrics()
            return
        }
    }
    func showAlertViewAfterEvaluationPolicyWithMessage(message: String)
    {
        showAlertWithTitle(title: "Error", message: message)
    }
    
    func errorMessageForLAErrorCode(errorCode: Int) -> String
    {
        var message = ""
        switch errorCode
        {
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"

        }
        
        return message
    }
    
    func navigateToAuthenticatedVC()
    {
        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "LoggedInVC")
        {
            DispatchQueue.main.async
                {
                    self.navigationController?.pushViewController(loggedInVC, animated: true)
                }
        }
    }
    
    func showAlertViewForNoBiometrics()
    {
        showAlertWithTitle(title:"Error", message: "This device does not have a Touch ID sensor.")
        
    }
        
        func showAlertWithTitle(title: String,message:String)
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async
            {
                self.present(alertVC, animated: true, completion: nil)
            }
        
    }
    

}//end

