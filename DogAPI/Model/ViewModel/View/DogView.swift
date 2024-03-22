//
//  DogView.swift
//  DogAPI
//
//  Created by Justyna Warzecha on 22/03/2024.
//

import SwiftUI

struct DogView: View {
    @ObservedObject var viewModel = DogViewModel()
    var body: some View {
        ZStack {
                   Color.yellow
                   VStack(spacing: 20) {
                       if let url = URL(string: viewModel.dogImageURL) {
                           AsyncImage(url: url, content: { image in
                               image.resizable().frame(width: 300, height: 300)
                                   .clipShape(RoundedRectangle(cornerRadius: 30))
                                   .overlay(RoundedRectangle(cornerRadius: 30).stroke(lineWidth: 2).foregroundColor(Color.black))
                               
                           }, placeholder: {
                               ProgressView()
                           })
                       } else {
                           Text("Chargement de l'image...")
                       }

                       Button(action: {
                           viewModel.fetchDogImage()
                       }) {
                           ZStack{
                               RoundedRectangle(cornerRadius: 30)
                                   .frame(width: 120, height: 60)
                                   .foregroundStyle(.black)
                               Image(systemName: "dog")
                                   .foregroundStyle(.white)
                                   .bold()
                                   .font(.largeTitle)
                           }
                       }
                   }
                   .onAppear(perform: viewModel.fetchDogImage)
               .padding()
               }
               .ignoresSafeArea()
    }
}

#Preview {
    DogView()
}
