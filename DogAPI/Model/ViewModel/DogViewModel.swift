//
//  DogViewModel.swift
//  DogAPI
//
//  Created by Justyna Warzecha on 22/03/2024.
//

import Foundation

class DogViewModel: ObservableObject {
    @Published var dogImageURL: String = ""
    private let apiURL = URL(string: "https://dog.ceo/api/breeds/image/random")!

    func fetchDogImage() {
        URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(Dog.self, from: data)
                    DispatchQueue.main.async {
                        self.dogImageURL = decodedResponse.message
                    }
                } catch {
                    print("Erreur de décodage: \(error)")
                }
            } else if let error = error {
                print("Erreur de requête: \(error)")
            }
        }.resume()
    }
}
