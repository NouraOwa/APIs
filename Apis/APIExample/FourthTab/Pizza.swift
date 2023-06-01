//
//  Pizza.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI
struct PizzaData: Codable, Identifiable {
    let id: Int
    let name: String
    let veg: Bool
    let price: Int
    let description: String
    let quantity: Int
}
struct Pizza: View {
    @State private var pizza = [PizzaData]()
    //(id: 0, name: "", description: "", image: "", price: 9, quantity: 0)
    var body: some View {
        ScrollView{
            VStack {
                Text("PIZZA").font(.largeTitle).bold()
                ForEach (pizza) { item in
                    VStack {
                        Text(item.name).font(.title2).bold()
                        Text(item.description)
                        Text("\(item.price)")
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.red.opacity(0.3))
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
            let url = URL(string: "https://pizza-and-desserts.p.rapidapi.com/pizzas")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, response) = try await URLSession.shared.data(for: request)
            let isSuccessful = isSuccessful(response: response as! HTTPURLResponse)
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode([PizzaData].self, from: data)
            pizza = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}
struct Pizza_Previews: PreviewProvider {
    static var previews: some View {
        Pizza()
    }
}
