//
//  RandomRiddles.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Riddles: Codable, Identifiable {
    let id = UUID()
    let title, question, answer: String
}

struct RandomRiddles: View {
    @State private var riddles = [Riddles]()
    //(title: "", question: "", answer: "")
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    Text("Random Riddles").font(.largeTitle).bold()
                    ForEach (riddles) { item in
                        VStack {
                            Text(item.title).font(.title).bold()
                            Text(item.question)
                            Text(item.answer)
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
            let url = URL(string: "https://api.api-ninjas.com/v1/riddles")!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([Riddles].self, from: data)
            riddles = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct RandomRiddles_Previews: PreviewProvider {
    static var previews: some View {
        RandomRiddles()
    }
}
