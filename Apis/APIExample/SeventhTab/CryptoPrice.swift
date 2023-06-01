//
//  CryptoPrice.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Crypto: Codable {
    let symbol, price: String
    let timestamp: Int
}
struct CryptoPrice: View {
    @State private var price = Crypto(symbol: "", price: "", timestamp: 0)
    var body: some View {
            ScrollView{
                VStack {
                    Text("Crypto Price").font(.largeTitle).bold()
                   // ForEach (price) { item in
                        VStack {
                            Text(price.symbol).font(.title).bold()
                            Text(price.price)
                            Text("\(price.timestamp)")
                                .frame (maxWidth: .infinity)
                                .foregroundColor (.black)
                                .font (.title2)
                                .padding(.all, 24)
                                .background (.gray.opacity(0.3))
                                .padding (.bottom, 30)
                        }.padding()
                    }
                }
           // }
        .task {
            await loadData ()
        }
    }
    func loadData( ) async {
        do {
            let symbol = "LTCBTC".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/cryptoprice?symbol=" + symbol!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(Crypto.self, from: data)
            price = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct CryptoPrice_Previews: PreviewProvider {
    static var previews: some View {
        CryptoPrice()
    }
}
