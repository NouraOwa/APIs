//
//  TextLanguage.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct TextLang: Codable {
    let iso, language: String
}

struct TextLanguage: View {
    @State private var textLanguage = TextLang(iso: "", language: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Text Language").font(.largeTitle).bold()
                //ForEach (bank) { item in
                    VStack {
                        Text(textLanguage.iso).font(.title).bold()
                        Text(textLanguage.language)
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
            let text = "Hello world!".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/textlanguage?text="+text!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(TextLang.self, from: data)
            textLanguage = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct TextLanguage_Previews: PreviewProvider {
    static var previews: some View {
        TextLanguage()
    }
}
