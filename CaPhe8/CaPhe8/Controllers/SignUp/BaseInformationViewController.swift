//
//  SignUpBasicInfoViewController.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/06/22.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import UIKit

class BaseInformationViewController: CustomUIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    // MARK: - Properties
    
    //: Name text field
    @IBOutlet weak var NameField: UITextField!
    //: Email text field
    @IBOutlet weak var EmailField: UITextField!
    //: Password text field
    @IBOutlet weak var PasswordField: UITextField!
    //: Confirm text field, this text field's value must like password text filed's value
    @IBOutlet weak var ConfirmPasswordField: UITextField!
    //: Next Button, when user press that button will go next screen
    @IBOutlet weak var NextScreenBT: UIButton!
    //: when have error this text field will be display
    @IBOutlet weak var ErrorDisplay: UILabel!
    
    //: Toolbar if you alreally have an account, go Sign In screen for log in to system
    @IBOutlet weak var ToolBar: UIToolbar!
    
    //: Text field tag
    enum Tag: CaseIterable {
        //: user name textfield
        case Name
        //: email textfield
        case Email
        //: password textfield
        case Password
        //: confirm password textfield
        case ConfirmPassword
        //: Gender
        case Gender
        //: Prefecture
        case Prefecture
        //: Job
        case Job
        //: Bỉrthday
        case Birthday
        //: return case to array
        static var asArray: [Tag] {return self.allCases}
        //: get index of item in array
        func asInt() -> Int {
            return Tag.asArray.firstIndex(of: self)!
        }
    }
    //: Name text field's value validate true or false
    private var NameValidate:Bool = false;
    //: Email text field's value validate true or false
    private var EmailValidate:Bool = false;
    //: Password text field's value validate true or false
    private var PasswordValidate:Bool = false;
    //: Confirm Password text field's value validate true or false
    private var ConfirmPasswordValidate:Bool = false;
    
    
    @IBOutlet weak var NextBT: UIButton!
    //: gender
    @IBOutlet weak var Gender: UITextField!
    let genderPicker = UIPickerView();
    
    //: Prefecture
    @IBOutlet weak var Prefecture: UITextField!
    let prefecturePicker = UIPickerView();
    
    //: JOB
    @IBOutlet weak var Job: UITextField!
    let jobPicker = UIPickerView();
    
    //: Birthday
    @IBOutlet weak var Birthday: UITextField!
    let birthdayPicker = UIDatePicker();
    
    //: Gender Data
    var GenderSelection:Array<String> = ["Female", "Male"]
    // Prefecture Data
    var PrefectureSelection:Array<String> = [
        "青森県",
        "秋田県",
        "石川県",
        "茨城県",
        "岩手県",
        "愛媛県",
        "大分県",
        "大阪府",
        "岡山県",
        "沖縄県",
        "香川県",
        "鹿児島県",
        "神奈川県",
        "岐阜県",
        "京都府",
        "熊本県",
        "群馬県",
        "高知県",
        "埼玉県",
        "佐賀県",
        "滋賀県",
        "静岡県",
        "島根県",
        "千葉県",
        "東京都",
        "徳島県",
        "栃木県",
        "鳥取県",
        "富山県",
        "長崎県",
        "長野県",
        "奈良県",
        "新潟県",
        "兵庫県",
        "広島県",
        "福井県",
        "福岡県",
        "福島県",
        "北海道",
        "三重県",
        "宮城県",
        "宮崎県",
        "山形県",
        "山口県",
        "山梨県",
        "和歌山県"];
    
    var JobSelection:Array<String> = [
        "Employee",
        "Public official",
        "Doctor・Lawyer",
        "Family-operated business・Free enterprise",
        "Temporary employee",
        "Part-time・ Contract employee",
        "Unemployed",
        "Student"];
    
    // MARK: Main Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        //: Do any additional setup after loading the view
        CustomDisplayView()
        //: Set tag
        genderPicker.tag = Tag.Gender.asInt();
        prefecturePicker.tag = Tag.Prefecture.asInt();
        jobPicker.tag = Tag.Job.asInt();
        birthdayPicker.tag = Tag.Birthday.asInt();
        
        //: Set Delegate
        Gender?.inputView = genderPicker
        genderPicker.delegate = self
        
        Prefecture?.inputView = prefecturePicker;
        prefecturePicker.delegate = self
        
        Job?.inputView = jobPicker;
        jobPicker.delegate = self
        
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date;
        Birthday?.inputView = birthdayPicker;
         //: Set Delegate
    }
    // MARK: - Navigation
    
    /*:
     - navigation back button executed
     - parameters:
     - sender: executed object
     */
    @IBAction func BackToPreviousScreen(_ sender: Any) {
        // Go back to the previous ViewController
        self.navigationController?.popViewController(animated: true)
    }
    /*:
     - Hide keyboard when editting did end
     - parameters:
     - sender: executed object
     */
    @IBAction func TapGestureHideKeyboard(_ sender: Any) {
        self.view.endEditing(true)
    }
    // MARK: - Action
    private func CustomDisplayView(){
        //: Screen 1: Button Corner Set
        NextScreenBT?.layer.cornerRadius = 25;
        NextScreenBT?.clipsToBounds = true
        
        //: Screen 2: Button Corner Set
        NextBT?.layer.cornerRadius = 25;
        NextBT?.clipsToBounds = true
    }
    /*:
     - next button disable check
     - parameters: None
     */
    private func IsEnableNextButton(){
        //: if name textfield's input, Email textfield' input and password textfield's input validated next button Enable
        if( NameValidate == true &&
            EmailValidate == true &&
            PasswordValidate == true &&
            ConfirmPasswordValidate == true){
            
            //: next button enable
            NextScreenBT.isEnabled = true;
            NextScreenBT.alpha = 1;
            
        }else{
            // disable next button
            NextScreenBT.isEnabled = false;
            NextScreenBT.alpha = 0.5;
            
        }
    }
    /*:
     TODO: Viết lại hàm cho gọn
     - Validate typing text filed input
     - parameters:
        - sender: object
     */
    @IBAction func ValidateWhileType(_ sender: UITextField) {
        //: text field tag
        let fieldTag = sender.tag as Int;

        switch fieldTag {
        //: user name
        case Tag.Name.asInt():
            
            Validation.shared.ValidateText(
                validateType: Validation.ValidationType.alphabeticString,
                textField: NameField,
                error: ErrorDisplay,
                alertMessgae: Validation.AlertMessages.invalidAlphabeticString)
            break;
        //: email
        case Tag.Email.asInt():
            
             Validation.shared.ValidateText(
                validateType: Validation.ValidationType.email,
                textField: EmailField,
                error: ErrorDisplay,
                alertMessgae: Validation.AlertMessages.inValidEmail)
             
            break;
        //: password
        case Tag.Password.asInt():
            
              Validation.shared.ValidateText(
                validateType: Validation.ValidationType.password,
                textField: PasswordField,
                error: ErrorDisplay,
                alertMessgae: Validation.AlertMessages.invalidAlphabeticString)
            
            break;
        //: confirm password
        case Tag.ConfirmPassword.asInt():
            
            Validation.shared.ValidateText(
                validateType: Validation.ValidationType.password,
                textField: ConfirmPasswordField,
                error: ErrorDisplay,
                alertMessgae: Validation.AlertMessages.invalidAlphabeticString,
                compareTextField: PasswordField)
            
            break;
        default:
            break;
        }
    }
    /*:
     - TODO: Viết lại hàm cho gọn
     - Validate typing text filed input
     - parameters:
     - sender: object
     */
    @IBAction func DoneEditting(_ sender: Any) {
        
        let textField = sender as! UITextField;
        let fieldTag = textField.tag as Int;
        let fieldText:String = (textField.text)!;
        
        let validate = Validation.shared
        
        switch fieldTag {
        case Tag.Name.asInt():
            // name validate
            NameValidate = validate.GetBoolTypeByValidateResults( validated: validate.Validate(values: (Validation.ValidationType.alphabeticString, fieldText)))
            break;
        case Tag.Email.asInt():
            // email
            EmailValidate = validate.GetBoolTypeByValidateResults( validated: validate.Validate(values: (Validation.ValidationType.email, fieldText)))
            break;
            // password
        case Tag.Password.asInt():
            PasswordValidate = Validation.shared.GetBoolTypeByValidateResults( validated: Validation.shared.Validate(values: (Validation.ValidationType.password, fieldText)))
            break;
            // confirm password
        case Tag.ConfirmPassword.asInt():
            ConfirmPasswordValidate = Validation.shared.GetBoolTypeByValidateResults( validated: Validation.shared.Validate(values: (Validation.ValidationType.password, fieldText)))
            break
        default:
            break;
        }
        IsEnableNextButton();
    }
    
    // MARK: Screen 2: Gender, Address
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case Tag.Gender.asInt(),
             Tag.Prefecture.asInt(),
             Tag.Job.asInt():
            return 1;
        case Tag.Birthday.asInt():
            return 3;
        default:
            return 0;
        }
    }
    // display number rows in column
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case Tag.Gender.asInt():
            return GenderSelection.count;
        case Tag.Prefecture.asInt():
            return PrefectureSelection.count;
        case Tag.Job.asInt():
            return JobSelection.count;
        case Tag.Birthday.asInt():
            return 3;
        default:
            return 0;
        }
    }
    // display content in a row
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case Tag.Gender.asInt():
            return GenderSelection[row];
        case Tag.Prefecture.asInt():
            return PrefectureSelection[row];
        case Tag.Job.asInt():
            return JobSelection[row];
        case Tag.Birthday.asInt():
            return nil;
        default:
            return nil;
        }
    }
    // set
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case Tag.Gender.asInt():
            Gender.text = GenderSelection[row];
        case Tag.Prefecture.asInt():
            Prefecture.text = PrefectureSelection[row];
        case Tag.Job.asInt():
            Job.text = JobSelection[row];
        case Tag.Birthday.asInt():
            break;
        default:
            break;
        }
    }
}

