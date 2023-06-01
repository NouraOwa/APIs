//
//  FifthTabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 12/11/1444 AH.
//

import SwiftUI

struct FifthTabBar: View {
            @State var selectedTab = 0
            
            var body: some View {
                NavigationStack{
                    VStack {
                        TabView {
                            // First tab
                            Dictionary()
                                .tabItem {
                                    Image(systemName: "house")
                                    Text("Home")
                                }
                            
                            // Second tab
                           IBAN()
                                .tabItem {
                                    Image(systemName: "rectangle.fill.on.rectangle.fill")
                                    Text("Feed")
                                }
                            
                            // Third tab
                            IBAN()
                                .tabItem {
                                    Image(systemName: "person")
                                    Text("Profile")
                                }
                            
                            // Fourth tab
                            IBAN()
                                .tabItem {
                                    Image(systemName: "flag")
                                    Text("Profile")
                                    
                                }
                            // fifth tab
                            IBAN()
                                .tabItem {
                                    Image(systemName: "timer")
                                    Text("Profile")
                                    
                                }
                        }
                    }
                }
            }
        }

struct FifthTabBar_Previews: PreviewProvider {
    static var previews: some View {
        FifthTabBar()
    }
}
