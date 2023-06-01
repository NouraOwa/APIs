//
//  Hobbbies.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct Hobby: Codable {
    let hobby: String
    let link: String
    let category: String
}
struct Hobbbies: View {
    @State private var hobby = Hobby(hobby: "", link: "", category: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Random Hobby").font(.largeTitle).bold()
                //ForEach (bank) { item in
                    VStack {
                        Text(hobby.hobby).font(.title).bold()
                        Text(hobby.link)
                        Text(hobby.category)
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
            let category = "general".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/hobbies?category="+category!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(Hobby.self, from: data)
            hobby = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct Hobbbies_Previews: PreviewProvider {
    static var previews: some View {
        Hobbbies()
    }
}
