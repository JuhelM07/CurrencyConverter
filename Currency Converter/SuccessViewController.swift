//
//  SuccessViewController.swift
//  Currency Converter
//
//  Created by Juhel on 26/08/2022.
//

import UIKit

class SuccessViewController: UIViewController {
    @IBOutlet weak var conversionRateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var desiredCurrency = String()
    var conversionRate = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = "Great now you have \(desiredCurrency) in your account"
        conversionRateLabel.text = "Your conversion rate was \(conversionRate)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        let presentingVC = self.presentingViewController!
            let navigationController = presentingVC is UINavigationController ? presentingVC as? UINavigationController : presentingVC.navigationController
        navigationController?.popToRootViewController(animated: false)

        self.dismiss(animated: true, completion: nil)
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
