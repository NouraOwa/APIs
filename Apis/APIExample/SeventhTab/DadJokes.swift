//
//  DadJokes.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct DadJoke: Codable, Identifiable {
    let id = UUID()
    let joke: String
}

struct DadJokes: View {
    @State private var joke = [DadJoke]()
    //(title: "", question: "", answer: "")
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    Text("Dad Jokes").font(.largeTitle).bold()
                    ForEach (joke) { item in
                        VStack {
                            Text(item.joke).font(.title).bold()
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
            let limit = "3".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/dadjokes?limit=" + limit!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([DadJoke].self, from: data)
            joke = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct DadJokes_Previews: PreviewProvider {
    static var previews: some View {
        DadJokes()
    }
}
