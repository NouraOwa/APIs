//
//  RandopPassword.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct RPass: Codable {
    let random_password: String
}
struct RandopPassword: View {
    @State private var pass = RPass(random_password: "")
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    NavigationLink(destination: SeventhTabBar()) {
                        Text("Random Password").font(.largeTitle).bold()}
                    VStack {
                        Text(pass.random_password).font(.title).bold()
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
            let url = URL(string: "https://api.api-ninjas.com/v1/passwordgenerator?length="+length!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(RPass.self, from: data)
            pass = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct RandopPassword_Previews: PreviewProvider {
    static var previews: some View {
        RandopPassword()
    }
}
