//
//  SalesTax.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Sales: Codable, Identifiable {
    let id = UUID()
    let zip_code, total_rate, state_rate, city_rate: String
    let county_rate, additional_rate: String
}
struct SalesTax: View {
    @State private var tax = [Sales]()
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    NavigationLink(destination: SixthTabBar()) {
                        Text("Sales Tax").font(.largeTitle).bold()}
                        ForEach (tax) { item in
                        VStack {
                            Text(item.zip_code).font(.title).bold()
                            Text(item.total_rate)
                            Text(item.state_rate)
                            Text(item.city_rate)
                            Text(item.county_rate)
                            Text(item.additional_rate)
                            
                                .frame (maxWidth: .infinity)
                                .foregroundColor (.black)
                                .font (.title2)
                                .padding(.all, 24)
                                .background (.gray.opacity(0.3))
                                .padding (.bottom, 30)
                        }.padding()
                    }
                                   }
                                   }
                                   }
                        .task {
                            await loadData ()
                        }
                                   }
                                   func loadData( ) async {
                        do {
                            let zip_code = "90210".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                            let url = URL(string: "https://api.api-ninjas.com/v1/salestax?zip_code="+zip_code!)!
                            var request = URLRequest(url: url)
                            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
                            
                            let (data, response) = try await URLSession.shared.data(for: request)
                            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
                            print(String(data: data, encoding: .utf8))
                            let serverNews = try JSONDecoder().decode([Sales].self, from: data)
                            tax = serverNews
                            
                        } catch {
                            print("error \(error)")
                        }
                    }
                                   
                                   }
                                   
                                   struct SalesTax_Previews: PreviewProvider {
                        static var previews: some View {
                            SalesTax()
                        }
                    }
