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
                }
                else
                {
                    if let error = error
                    {
                        //Display Error
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
    
    func showAlertViewForNoBiometrics()
    {
        showAlertWithTitle(title:"Error", message: "This device does not have a Touch ID sensor.")
        
    }
        
        func showAlertWithTitle(title: String,message:String)
    {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        self.present(alertVC, animated: true, completion: nil)
        
    }
    

}//end

