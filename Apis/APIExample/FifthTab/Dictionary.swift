//
//  Dictionary.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct FindWord: Codable,Identifiable {
    let id = UUID()
    let word: String
    let definition: String
}
struct Dictionary: View {
    @State private var words = FindWord(word: "", definition: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Word").font(.largeTitle).bold()
                    VStack {
                        Text("\(words.word)").font(.title).bold()
                        Text("\(words.definition)")
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.gray.opacity(0.3))
                            .padding (.bottom, 30)
                    }.padding()
                }
            }
        .task {
            await loadData ()
        }
    }
    func loadData( ) async {
        do {
            let word = "code".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/dictionary?word=" + word!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(FindWord.self, from: data)
            words = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct Dictionary_Previews: PreviewProvider {
    static var previews: some View {
        Dictionary()
    }
}
