//
//  RandomUsers.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct RandomUser: Codable {
    let username, sex, address, name: String
    let email, birthday: String
}
struct RandomUsers: View {
    @State private var user = RandomUser(username: "", sex: "", address: "", name: "", email: "", birthday: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("User").font(.largeTitle).bold()
               // ForEach (user) { item in
                    
                    VStack {
                        Text(user.username).font(.title).bold()
                        Text(user.sex)
                        Text(user.address)
                        Text(user.name)
                        Text(user.email)
                        Text(user.birthday)

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
            let url = URL(string: "https://api.api-ninjas.com/v1/randomuser")!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(RandomUser.self, from: data)
            user = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}
struct RandomUsers_Previews: PreviewProvider {
    static var previews: some View {
        RandomUsers()
    }
}
