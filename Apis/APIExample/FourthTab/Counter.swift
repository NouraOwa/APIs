//
//  Counter.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Counters: Codable,Identifiable {
    let id: String
    let value: Int
}

struct Counter: View {
    @State private var count = Counters(id: "", value: 0)
    var body: some View {
        NavigationStack{
        ScrollView{
            VStack {
                NavigationLink(destination: FifthTabBar()) {
                    Text("Counter").font(.largeTitle).bold()}
                    VStack {
                        Text("\(count.value)").font(.title2).bold()
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
            let url = URL(string: "https://api.api-ninjas.com/v1/counter?id=test_id&hit=true")!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(Counters.self, from: data)
            count = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct Counter_Previews: PreviewProvider {
    static var previews: some View {
        Counter()
    }
}
