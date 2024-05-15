//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Erick Quintanar on 5/13/24.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var segmentedView: UISegmentedControl!
    
    // Data for Picker View
    let pickerData = [["Fahrenheit - °F", "Celsius - °C", "Kelvin - K"]]
    let pickerValue = ["Imperial", "Metric", "Default"]
    var selectedRow = 0
    
    var segmentSelected = 0
    
    // Notification to pass data to the View Controller
    let notification = Notification.Name("PassLocationNotification")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        NotificationCenter.default.post(name: notification, object: nil, userInfo: ["pickerData": pickerValue[selectedRow], "segmentData": segmentSelected])
        self.dismiss(animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
    @IBAction func switchViewAction(_ sender: UISegmentedControl) {
        segmentSelected = sender.selectedSegmentIndex
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
