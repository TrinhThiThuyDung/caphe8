//
//  CustomNavigationController.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/06/02.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import UIKit
import Foundation

/***
 * Custom Navigation for each screen
 * Each screen viewcontrol will be extand this class
 **/
class CustomUIViewController: UIViewController {
    //: Common Border Color
    let BorderColor : UIColor = UIColor(red: 243 / 255, green: 178 / 255, blue: 189 / 255, alpha: 1.0)
    //: Common Text Color
    let TextColor : UIColor = UIColor(red: 237 / 255, green: 116 / 255, blue: 56 / 255, alpha: 1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //: custom bar back button item style
        SetTitleBarBackButtonItem()
    }
    private func SetTitleBarBackButtonItem(){
        self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Futura", size: 17)!], for: UIControl.State.normal)
    }
    
    /*:
     *. Set Color By CGFloat
     *. - parameters:
     *.   - red:
     */
    public func SetColorByCGFloat(red : Float, green : Float , blue : Float, alpha : Float = 1.0)->UIColor {
        return UIColor(
            red   : CGFloat( red ) / 255.0,
            green : CGFloat( green ) / 255.0,
            blue  : CGFloat( blue ) / 255.0,
            alpha : CGFloat( alpha )
        )
    }
    /*:
     *. set image background navigation
     *. - parameters:
     *.   - imageName: image name to get
     */
    public func CustomSetNavigationBackgroundImage(imageName : String){
        self.navigationController?.navigationBar.setBackgroundImage( UIImage(named: imageName), for: .default );
    }
    /*:
     *. set image background for navigation by StoryBoardID
     *. - parameters:
     *.    - None
     */
    private func SetNavigationBackgroundImageByStoryboardID(){
        // Navigation Background Image Set
        let imageBackgroundYellow = "navigationBar"; // image name
        // storyBoard ID
        let storyBoardID: String = self.restorationIdentifier ?? "default"
        // Custom Navigation background image by story board id
        switch storyBoardID {
            default:
                CustomSetNavigationBackgroundImage(imageName: imageBackgroundYellow);
        }
    }
    /*:
     *. return image view (UIImageView) from image name and size
     *. - parameters:
     *.    - imageName:String image name
     *.    - width:Double image width size
     *.    - hight:Double image hight size
     */
    private func SetImageViewByImageNameAndSize(imageName: String, width: Double, hight: Double ) -> UIImageView {
        // get Image by name
        let getImage = UIImage(named: imageName)
        // set image view
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: hight ))
        imageView.contentMode = .scaleAspectFit
        imageView.image = getImage
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        return imageView
    }
    /*:
     *. - Return image view (UIImageView) from hexa code
     *. - Parameters:
     *.    - hex:String hexa code
     */
    func HexStringToUIColor (hex:String) -> UIColor {
        //: convert hex string2 to Uppercase string
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        //: check hex string have # or not
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        // check string length, if unlike 6, return color is grey
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        //: ???
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        //: return UIColor
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    /*:
     *. Set image for bar button item
     *. - Parameters:
     *.    - imagename: image name
     *. -Return:
     *.    - bar button item:UIBarButtonItem
     *.
     */
    func SetBarImageView(imageName: String) -> UIBarButtonItem {
        return UIBarButtonItem(customView: SetImageViewByImageNameAndSize(imageName: imageName, width: 35, hight: 35 ))
    }
    /*:
     *. Set bar button
     *. - Parameters:
     *.     - imageName:String image name
     *.     - selector:Selector action
     *. - Return:
     *.     - Bar button item:UIBarButtonItem
     */
    func BarButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        //: breate UIButton
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
    

}
/*:
 *. - Extension addBorder function to custom border style
 *. - Parameters:
 *.     - edge: top, right, left or botton of border
 *.     - color: color of border
 *.     - thickness: width of border
 */
extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        
        let border = CALayer()
        
        switch edge {
            // top
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: thickness)
            // bottom
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: self.bounds.height - thickness,  width: self.bounds.width
                    , height: thickness)
            // left
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0,  width: thickness, height: self.bounds.height)
            // right
            case UIRectEdge.right:
                border.frame = CGRect(x: self.bounds.width - thickness, y: 0,  width: thickness, height: self.bounds.height)
            
            default:
                break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
// MARK: UITextField Extension
/*:
 *. - Extension UITextField function
 *. -Function:
 *.     - PlaceHolderColor
 *.     - CustomBottomBorder
 */
extension UITextField{
    // Set place holder color
    @IBInspectable var PlaceHolderColor: UIColor? {
        get {
            return self.PlaceHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    // Set Bottom border color
    @IBInspectable var CustomBottomBorder: UIColor? {
        get{
            return self.CustomBottomBorder
        }
        set{
            self.borderStyle = UITextField.BorderStyle.none;
            let border = CALayer()
            border.frame = CGRect(x: 0, y: self.bounds.height - 1,  width: self.bounds.width
                , height: 1)
            border.backgroundColor = newValue?.cgColor
        
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }
}
