//
//  Models.swift
//  LearningApp
//
//  Created by Dean Vayias on 2023-04-15.
//

import Foundation

struct Module: Decodable, Identifiable {
    
    var id: Int
    var category: String
    var content: Content
    var test: Test
}

struct Content: Decodable, Identifiable {
    
    var id: Int
    var image: String
    var description: String
    var lessons: [Lesson]
    
}

struct Lesson: Decodable, Identifiable {
    
    var id: Int
    var title: String
    var video: String
    var explanation: String
    
}

struct Test: Decodable, Identifiable {
    
    var id: Int
    var image: String
    var description: String
    var questions: [Question]
}

struct Question: Decodable, Identifiable {
    
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}

struct MusicTerm: Decodable, Identifiable {
    var id: Int
    var term: String
    var definition: String
}

