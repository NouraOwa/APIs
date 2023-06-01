//
//  SixthTabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI

struct SixthTabBar: View {
            @State var selectedTab = 0
            var body: some View {
                NavigationStack{
                    VStack {
                        TabView {
                            // First tab
                            Inflation()
                                .tabItem {
                                    Image(systemName: "house")
                                    Text("Home")
                                }
                            
                            // Second tab
                           Emojis()
                                .tabItem {
                                    Image(systemName: "rectangle.fill.on.rectangle.fill")
                                    Text("Feed")
                                }
                            
                            // Third tab
                            TextLanguage()
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("Profile")
                                }
                            
                            // Fourth tab
                            Hobbbies()
                                .tabItem {
                                    Image(systemName: "flag")
                                    Text("Profile")
                                    
                                }
                            // fifth tab
                            RandopPassword()
                                .tabItem {
                                    Image(systemName: "timer")
                                    Text("Profile")
                                    
                                }
                        }
                    }
                }
            }
        }

struct SixthTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SixthTabBar()
    }
}
