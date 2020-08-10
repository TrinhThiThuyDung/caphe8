//
//  TakePhotoViewController.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/07/06.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import UIKit

class TakePhotoViewController: CustomUIViewController {

    @IBOutlet weak var NextScreenBT: UIButton!
    @IBOutlet weak var TakePhotoBT: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NextScreenBT?.layer.cornerRadius = 25;
        NextScreenBT?.clipsToBounds = true
        
        TakePhotoBT?.layer.cornerRadius = 4;
        TakePhotoBT?.clipsToBounds = true
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
