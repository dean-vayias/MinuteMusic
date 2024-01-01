//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by Dean Vayias on 4/13/23.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                // Tab 1: HomeView
                HomeView()
                    .environmentObject(ContentModel())
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .padding(.bottom, 10) // Add padding as needed

                // Tab 2: GameView
                GameView()
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Game")
                    }
                    .padding(.bottom, 10) // Add padding as needed

                // Tab 3: MusicDictView
                MusicDictView()
                    .environmentObject(ContentModel()) // If MusicDictView requires ContentModel
                    .tabItem {
                        Image(systemName: "music.note")
                        Text("Music Dictionary")
                    }
                    .padding(.bottom, 10) // Add padding as needed
            }
            .onAppear {
                // Adjust tab bar appearance globally
                UITabBar.appearance().barTintColor = UIColor.systemBackground
                UITabBar.appearance().backgroundColor = UIColor.systemBackground
            }
        }
    }
}
