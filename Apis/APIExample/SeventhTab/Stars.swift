//
//  Stars.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Star: Codable, Identifiable {
    let id = UUID()
    let name, constellation, right_ascension, declination: String
}

struct Stars: View {
    @State private var star = [Star]()
    //(title: "", question: "", answer: "")
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    Text("Stars").font(.largeTitle).bold()
                    ForEach (star) { item in
                        VStack {
                            Text(item.name).font(.title).bold()
                            Text(item.constellation)
                            Text(item.right_ascension)
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
            let name = "vega".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/stars?name="+name!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([Star].self, from: data)
            star = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct Stars_Previews: PreviewProvider {
    static var previews: some View {
        Stars()
    }
}
