//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Dean Vayias on 4/25/23.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var lesson: Lesson {
        
        if model.currentModule != nil &&
            index < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[index]
        }
        else {
            return Lesson(id: 0, title: "", video: "", explanation: "")
        }
    }
    
    var body: some View {
        
        // Lesson card
        ZStack (alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            HStack (spacing: 30) {
                
                Text(String(index + 1))
                    .bold()
                
                Text(lesson.title)
                    .bold()
                
                
            }
            .padding()
        }
            .padding(.bottom, 5)
        
    }
}
