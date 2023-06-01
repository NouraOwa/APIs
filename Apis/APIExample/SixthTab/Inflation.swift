//
//  Inflation.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Inflat: Codable,Identifiable {
    let id = UUID()
    let country, type, period: String
    //let monthlyRatePct, yearlyRatePct: Double
}
struct Inflation: View {
    @State private var inflation = [Inflat]()
    var body: some View {
        ScrollView{
            VStack {
                Text("Inflation").font(.largeTitle).bold()
                ForEach (inflation) { item in
                    VStack {
                        Text(item.country).font(.title2).bold()
                        Text(item.type)
                        Text(item.period)
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.pink.opacity(0.3))
                            .padding (.bottom, 30)
                    }.padding()
                }
            }
        }
        .task {
            await loadData ()
        }
    }
    func loadData( ) async {
        do {
            let country = "United States".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/inflation?country=" + country!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([Inflat].self, from: data)
            inflation = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct Inflation_Previews: PreviewProvider {
    static var previews: some View {
        Inflation()
    }
}
