//
//  Airlines.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Airline: Codable,Identifiable {
    let id = UUID()
    let iata, icao: String
    let name: String
}
struct Airlines: View {
    @State private var airline = [Airline]()
    var body: some View {
        ScrollView{
            VStack {
                Text("Airlines").font(.largeTitle).bold()
                ForEach (airline) { item in
                    VStack {
                        Text(item.name).font(.title2).bold()
                        Text(item.iata)
                        Text(item.icao)
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
            let name = "Singapore Airlines".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/airlines?name="+name!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([Airline].self, from: data)
            airline = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct Airlines_Previews: PreviewProvider {
    static var previews: some View {
        Airlines()
    }
}
