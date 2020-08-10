//
//  SignUpWeightHighViewController.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/06/22.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import UIKit

class SignUpWeightHighViewController: CustomUIViewController {
   
    @IBOutlet weak var NextScreenBT: UIButton!
    
    @IBOutlet weak var WeightField: UITextField!
    @IBOutlet weak var HighField: UITextField!
    
    @IBOutlet weak var HipsField: UITextField!
    @IBOutlet weak var WaistField: UITextField!
    @IBOutlet weak var BreastField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CustomDisplayView();
    }
    private func CustomDisplayView(){
        
        // Button Corner Set
        NextScreenBT?.layer.cornerRadius = 25;
        NextScreenBT?.clipsToBounds = true
        // Button Corner Set
        
        WeightField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        HighField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
         BreastField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
         WaistField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
         HipsField?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
    }
  
    @IBAction func BackToPreviousScreen(_ sender: Any) {
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
 
}
