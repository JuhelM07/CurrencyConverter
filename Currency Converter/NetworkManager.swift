//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Juhel on 24/08/2022.
//

import Foundation

let apiKey = "4f7198535dcc85ebe50cd81c"

struct Response: Codable {
    let result: String
    let conversion_rate: Double
    let conversion_result: Double
}

class NetworkManager {
    func getData(currentCurreny: String, desiredCurrency: String, amount: String, completionHandler:@escaping (_ currencyObject:Response)->Void) {
        let url = "https://v6.exchangerate-api.com/v6/\(apiKey)/pair/\(currentCurreny)/\(desiredCurrency)/\(amount)"
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                fatalError("FAILED")
            }
            
            guard let json = result else { return }

            completionHandler(json)
        }.resume()
    }
}
