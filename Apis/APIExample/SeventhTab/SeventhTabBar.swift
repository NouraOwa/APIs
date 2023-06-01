//
//  SeventhTabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI

struct SeventhTabBar: View {
                @State var selectedTab = 0
                var body: some View {
                    NavigationStack{
                        VStack {
                            TabView {
                                // First tab
                                RandomRiddles()
                                    .tabItem {
                                        Image(systemName: "house")
                                        Text("Home")
                                    }
                                
                                // Second tab
                               Stars()
                                    .tabItem {
                                        Image(systemName: "rectangle.fill.on.rectangle.fill")
                                        Text("Feed")
                                    }
                                
                                // Third tab
                                DadJokes()
                                    .tabItem {
                                        Image(systemName: "person")
                                        Text("Profile")
                                    }
                                
                                // Fourth tab
                                DNSLockup()
                                    .tabItem {
                                        Image(systemName: "flag")
                                        Text("Profile")
                                        
                                    }
                                // fifth tab
                                CryptoPrice()
                                    .tabItem {
                                        Image(systemName: "timer")
                                        Text("Profile")
                                        
                                    }
                            }
                        }
                    }
                }
            }

struct SeventhTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SeventhTabBar()
    }
}
