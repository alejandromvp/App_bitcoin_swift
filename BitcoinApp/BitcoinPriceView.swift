//
//  ContentView.swift
//  BitcoinApp
//
//  Created by Alejandro Villagrán Poblete on 31-07-23.
//

import SwiftUI

extension Color {
  static let bitcoinGreen: Color = Color.green.opacity(0.9)
}

struct BitcoinPriceView: View {
  @ObservedObject var viewModel: BitcoinPriceViewModel
  @State private var selectedCurrency: Currency = .eur
    var body: some View {
      VStack(spacing: 0){
        Text("Actualizado \(viewModel.lastUpdated)")
          .padding([.top, .bottom])
          .foregroundColor(.bitcoinGreen)
        TabView(selection: $selectedCurrency){
          ForEach(viewModel.priceDetails.indices, id: \.self){ index in
            let priceDetails = viewModel.priceDetails[index]
            PriceDetailView(priceDetails: priceDetails)
              .tag(priceDetails.currency)
          }
        }
        .refreshable {
                        print("Do your refresh work here")
                    }
        .tabViewStyle(PageTabViewStyle())
        VStack(spacing: 0){
          HStack(alignment: .center){
            Picker(selection: $selectedCurrency, label: Text("currency"), content: {
              Text("\(Currency.usd.icon) \(Currency.usd.code)").tag(Currency.usd)
              Text("\(Currency.eur.icon) \(Currency.eur.code)").tag(Currency.eur)
              Text("\(Currency.gbp.icon) \(Currency.gbp.code)").tag(Currency.gbp)
            })
            .padding(.leading)
            Spacer()
            Button(action: viewModel.onAppear){
              Image(systemName: "arrow.clockwise")
            }
            .padding(.trailing)
          }
          .padding(.top)
          Link(
            "Desarrollada por Alejandro Villagran", destination: URL(string: "https://aleMVP")!
          )
          .font(.caption)
        }
        .foregroundColor(.bitcoinGreen)
      }
      .onAppear(perform: viewModel.onAppear)
      .pickerStyle(MenuPickerStyle())
    }
}

struct PriceDetailView: View{
  let priceDetails: PriceDetails
  var body: some View{
    ZStack{
      Color.bitcoinGreen
      VStack{
        Text(priceDetails.currency.icon)
          .font(.largeTitle)
        Text("1 Bitcoin  =")
          .bold()
          .font(.title2)
        Text("\(priceDetails.rate) \(priceDetails.currency.code)")
          .bold()
          .font(.largeTitle)
      }
      .foregroundColor(.white)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      BitcoinPriceView(viewModel: BitcoinPriceViewModel())
    }
}
