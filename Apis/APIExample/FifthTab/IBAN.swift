//
//  IBAN.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Iban: Codable, Identifiable {
    let id = UUID()
    let iban, bankName, accountNumber, bankCode: String
}
struct IBAN: View {
    @State private var bank = Iban(iban: "", bankName: "", accountNumber: "", bankCode: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Account Information").font(.largeTitle).bold()
                //ForEach (bank) { item in
                    VStack {
                        Text(bank.iban).font(.title).bold()
                        Text(bank.bankName)
                        Text(bank.accountNumber)
                        Text(bank.bankCode)
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
            let iban = "DE16200700000532013000".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/iban?iban=" + iban!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(Iban.self, from: data)
            bank = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct IBAN_Previews: PreviewProvider {
    static var previews: some View {
        IBAN()
    }
}
