//
//  Emojis.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Emoji: Codable, Identifiable{
    let id = UUID()
    let code, character: String
    let name, group, subgroup: String
}
struct Emojis: View {
    @State private var emoji = [Emoji]()
    //(code: "", character: "", name: "", group: "", subgroup: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Emojis").font(.largeTitle).bold()
                ForEach (emoji) { item in
                    VStack {
                        Text(item.code).font(.title).bold()
                        Text(item.character)
                        Text(item.name)
                        Text(item.group)
                        Text(item.subgroup)
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
        .task {
            await loadData ()
        }
    }
    func loadData( ) async {
        do {
            let length = "16".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let name = "slightly smiling face".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/emoji?name="+name!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([Emoji].self, from: data)
            emoji = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct Emojis_Previews: PreviewProvider {
    static var previews: some View {
        Emojis()
    }
}
