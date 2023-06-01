//
//  FourthTabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI

struct FourthTabBar: View {
        @State var selectedTab = 0
        
        var body: some View {
            NavigationStack{
                VStack {
                    TabView {
                        // First tab
                        KFC()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                        
                        // Second tab
                       Pizza()
                            .tabItem {
                                Image(systemName: "rectangle.fill.on.rectangle.fill")
                                Text("Feed")
                            }
                        
                        // Third tab
                        Dessert()
                            .tabItem {
                                Image(systemName: "person")
                                Text("Profile")
                            }
                        
                        // Fourth tab
                        Airlines()
                            .tabItem {
                                Image(systemName: "flag")
                                Text("Profile")
                                
                            }
                        // fifth tab
                        Counter()
                            .tabItem {
                                Image(systemName: "timer")
                                Text("Profile")
                                
                            }
                    }
                }
            }
        }
    }

struct FourthTabBar_Previews: PreviewProvider {
    static var previews: some View {
        FourthTabBar()
    }
}
