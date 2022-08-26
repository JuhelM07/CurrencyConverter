//
//  ViewController.swift
//  Currency Converter
//
//  Created by Juhel on 23/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var currentCurrencyTF: UITextField!
    @IBOutlet weak var desiredCurrencyTF: UITextField!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var swapButton: UIButton!
    
    let currency = ["AED", "BDT", "CAD", "CHF", "GBP", "JPY", "MAD", "MXN", "NZD", "PKR", "SAR", "SGD", "TRY", "USD"]
    
    let networkManager = NetworkManager()
    
    var currencyPickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCurrencyTF.inputView = currencyPickerView
        desiredCurrencyTF.inputView = currencyPickerView
        
        currencyPickerView.delegate = self
        currencyPickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        currentCurrencyTF.inputAccessoryView = toolBar
        desiredCurrencyTF.inputAccessoryView = toolBar
        
    }
    
    @objc func donePicker() {
        currentCurrencyTF.resignFirstResponder()
        desiredCurrencyTF.resignFirstResponder()
    }
    @IBAction func swapCurrency(_ sender: Any) {
        let temp = currentCurrencyTF.text
        currentCurrencyTF.text = desiredCurrencyTF.text
        desiredCurrencyTF.text = temp
    }
    
    @IBAction func calculateTapped(_ sender: Any) {
        
        guard let currentCurrency = currentCurrencyTF.text, let desiredCurrency = desiredCurrencyTF.text, let amount = amountTF.text else { return }
        
        networkManager.getData(currentCurreny: currentCurrency, desiredCurrency: desiredCurrency, amount: amount, completionHandler: { (currency) in
            
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let convertVC = storyboard.instantiateViewController(withIdentifier: "ConvertViewController") as! ConvertViewController
                convertVC.amountEntered = amount
                convertVC.conversionResult = currency.conversion_result
                convertVC.conversionRate = currency.conversion_rate
                convertVC.currentCurrency = currentCurrency
                convertVC.desiredCurrency = desiredCurrency
                self.navigationController?.pushViewController(convertVC, animated: true)
            }
        })
        
        //segue to next screen
        //pass amount
        //pass conversion result
        //pass conversion rate
        
        
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentCurrencyTF.isEditing {
            currentCurrencyTF.text = currency[row]
        } else if desiredCurrencyTF.isEditing {
            desiredCurrencyTF.text = currency[row]
        }
    }
    
    
}

