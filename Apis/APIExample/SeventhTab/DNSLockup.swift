//
//  DNSLockup.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct DNS: Codable, Identifiable {
    let id = UUID()
    let record_type: String
    let value: String?
}
struct DNSLockup: View {
    @State private var dns = [DNS]()
    //(title: "", question: "", answer: "")
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack {
                    Text("DNS Lockup").font(.largeTitle).bold()
                    ForEach (dns) { item in
                        VStack {
                            Text(item.record_type).font(.title).bold()
                            Text(item.value ?? "wgyf8z8cgvm2qmxpnbnldrcltvk4xqfn")
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
            let domain = "example.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/dnslookup?domain="+domain!)!
            var request = URLRequest(url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField: "X-Api-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([DNS].self, from: data)
            dns = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct DNSLockup_Previews: PreviewProvider {
    static var previews: some View {
        DNSLockup()
    }
}
