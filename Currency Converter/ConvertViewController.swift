//
//  ConvertViewController.swift
//  Currency Converter
//
//  Created by Juhel on 26/08/2022.
//

import UIKit

class ConvertViewController: UIViewController {
    @IBOutlet weak var currentCurrencyLabel: UILabel!
    @IBOutlet weak var desiredCurrencyLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    var amountEntered = String()
    var conversionResult = Double()
    var desiredCurrency = String()
    var currentCurrency = String()
    var conversionRate = Double()
    
    var timeRemaining: Int = 30
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentCurrencyLabel.text = "\(amountEntered) \(currentCurrency)"
        desiredCurrencyLabel.text = "\(conversionResult) \(desiredCurrency)"
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createTimer()

    }
    
    @IBAction func convertTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let successVC = storyboard.instantiateViewController(withIdentifier: "SuccessViewController") as! SuccessViewController
        successVC.desiredCurrency = "\(conversionResult) \(desiredCurrency)"
        successVC.conversionRate = conversionRate
        self.present(successVC, animated: true, completion: nil)
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc func fireTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        } else {
            timer.invalidate()
            navigationController?.popToRootViewController(animated: true)
        }
        timerLabel.text = "\(timeRemaining) sec left"
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
