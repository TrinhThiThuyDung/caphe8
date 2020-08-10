//
//  SignUpBodyMeasurementsViewController.swift
//  CaPhe8
//
//  Created by チン・ズン on 2019/06/22.
//  Copyright © 2019 チン・ズン. All rights reserved.
//

import UIKit

class SignUpBaseInFor2ViewController: CustomUIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var NextBT: UIButton!
    // gender
    @IBOutlet weak var Gender: UITextField!
    let genderPicker = UIPickerView();
    
    // Prefecture
    @IBOutlet weak var Prefecture: UITextField!
    let prefecturePicker = UIPickerView();
    
    // JOB
    @IBOutlet weak var Job: UITextField!
    let jobPicker = UIPickerView();
    
    // City
    @IBOutlet weak var City: UITextField!
    let cityPicker = UIPickerView();
    
    // Birthday
    @IBOutlet weak var Birthday: UITextField!
    let birthdayPicker = UIDatePicker();
    
    // Gender Data
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
    
    enum PickerTag : String, CaseIterable{
        case Gender
        case Prefecture
        case Job
        case City
        case Birthday
        
        static var asArray: [PickerTag] {return self.allCases}
        
        func asInt() -> Int {
            return PickerTag.asArray.firstIndex(of: self)!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        CustomDisplayView();
        
        genderPicker.tag = PickerTag.Gender.asInt();
        prefecturePicker.tag = PickerTag.Prefecture.asInt();
        jobPicker.tag = PickerTag.Job.asInt();
        cityPicker.tag = PickerTag.City.asInt();
        birthdayPicker.tag = PickerTag.Birthday.asInt();
        
        Gender?.inputView = genderPicker
        genderPicker.delegate = self
        Gender?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        
        
        Prefecture?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        Prefecture?.inputView = prefecturePicker;
        prefecturePicker.delegate = self
        
        Job?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        Job?.inputView = jobPicker;
        jobPicker.delegate = self
        
        City?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        City?.inputView = cityPicker;
        cityPicker.delegate = self
        
        Birthday?.layer.addBorder( edge: UIRectEdge.bottom , color: BorderColor, thickness: 1.0)
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date;
        Birthday.inputView = birthdayPicker;
    }
    private func CustomDisplayView() {
        
        // Button Corner Set
        NextBT?.layer.cornerRadius = 25;
        NextBT?.clipsToBounds = true
        // Button Corner Set
    self.navigationItem.backBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Futura", size: 17)!], for: UIControl.State.normal)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
            case PickerTag.Gender.asInt(),
                 PickerTag.Prefecture.asInt(),
                 PickerTag.Job.asInt(),
                 PickerTag.City.asInt():
                return 1;
            case PickerTag.Birthday.asInt():
                return 3;
            default:
                return 0;
        }
    }
    // display number rows in column
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
            case PickerTag.Gender.asInt():
                return GenderSelection.count;
            case PickerTag.Prefecture.asInt():
                return PrefectureSelection.count;
            case PickerTag.Job.asInt():
                return JobSelection.count;
            case PickerTag.City.asInt():
                return 1;
            case PickerTag.Birthday.asInt():
                return 3;
            default:
                return 0;
        }
    }
    // display content in a row
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
            case PickerTag.Gender.asInt():
                return GenderSelection[row];
            case PickerTag.Prefecture.asInt():
                return PrefectureSelection[row];
            case PickerTag.Job.asInt():
                return JobSelection[row];
            case PickerTag.City.asInt():
                return nil;
            case PickerTag.Birthday.asInt():
                return nil;
            default:
                return nil;
        }
    }
    // set
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
            case PickerTag.Gender.asInt():
                Gender.text = GenderSelection[row];
            case PickerTag.Prefecture.asInt():
                Prefecture.text = PrefectureSelection[row];
            case PickerTag.Job.asInt():
                Job.text = JobSelection[row];
            case PickerTag.City.asInt():
                break;
            case PickerTag.Birthday.asInt():
                break;
            default:
                break;
        }
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
