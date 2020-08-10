//
//  SignUpPasswordViewController.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/06/22.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: CustomUIViewController {

    @IBOutlet weak var ConfirmPasswordField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    
    @IBOutlet weak var NextWeightHighScreenBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CustomDisplayView();
    }
    
    private func CustomDisplayView(){
        PasswordField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        ConfirmPasswordField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        // Button Corner Set
        NextWeightHighScreenBT?.layer.cornerRadius = 25;
        NextWeightHighScreenBT?.clipsToBounds = true
        // Button Corner Set
    }
    @IBAction func BackToPreviousScreen(_ sender: Any) {
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
