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
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
