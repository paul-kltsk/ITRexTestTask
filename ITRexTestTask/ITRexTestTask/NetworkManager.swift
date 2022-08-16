//
//  NetworkManager.swift
//  ITRexTestTask
//
//  Created by Павел Кулицкий on 11.02.22.
//

import Foundation

class NetworkManager {
    
    static func getCurrencyData(complition: @escaping (CurrencyModel) -> ()) {
        
        guard let url = URL(string: "https://belarusbank.by/api/kursExchange") else {
            print("Ошибка в получении URL адресса")
            return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                let jsonDecoder = JSONDecoder()
                let currency = try jsonDecoder.decode(Currency.self, from: data)
                complition(currency[0])
            } catch let error {
               print("Localization error: \(error)")
            }
            
        }.resume()
    }
    
}
