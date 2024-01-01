//
//  ContentModel.swift
//  LearningApp
//
//  Created by Dean Vayias on 2023-04-15.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var codeText = String()
    
    // Current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    // List of music terms
    @Published var musicTerms = [MusicTerm]()
    
    init() {
        // Download remote json file and parse data
        getRemoteData()
        
        // Load music dictionary data
        loadMusicDictData {
            // Handle any additional setup or actions after music dictionary data is loaded
        }
    }

    
    // MARK: - Data methods
    
    func getRemoteData() {
        // String path
        let urlString = "https://dean-vayias.github.io/MinuteMusic/data2.json"
        
        // Create a url object
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            
            // Create a URLSession task for asynchronous loading
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                // Handle errors
                guard error == nil else {
                    print("Error loading remote data: \(error!)")
                    return
                }
                
                // Ensure data is not nil
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    // Create JSON decoder
                    let decoder = JSONDecoder()
                    
                    // Decode remote data
                    let modules = try decoder.decode([Module].self, from: data)
                    
                    DispatchQueue.main.async {
                        // Append parsed modules into modules property
                        self.modules += modules
                    }
                } catch {
                    // Handle error loading or parsing remote data
                    print("Error loading or parsing remote data: \(error)")
                }
            }
            
            // Start the URLSession task
            task.resume()
        }
    }

    // MARK: - Music Dictionary Data Methods
    
    func loadMusicDictData(completion: @escaping () -> Void) {
        // String path for the music dictionary JSON file
        let musicDictUrlString = "https://dean-vayias.github.io/MinuteMusic/musicdict.json"
        
        // Create a URL object for the music dictionary
        if let musicDictUrl = URL(string: musicDictUrlString) {
            let urlRequest = URLRequest(url: musicDictUrl)
            
            // Create a URLSession task for asynchronous loading
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                // Handle errors
                guard error == nil else {
                    print("Error loading music dictionary data: \(error!)")
                    return
                }
                
                // Ensure data is not nil
                guard let data = data else {
                    print("No data received")
                    return
                }
                do {
                    // Create JSON decoder
                    let decoder = JSONDecoder()
                    
                    // Decode music dictionary data
                    let musicTerms = try decoder.decode([MusicTerm].self, from: data)
                    
                    DispatchQueue.main.async {
                        // Clear existing musicTerms before updating
                        self.musicTerms.removeAll()
                        
                        // Update the musicTerms property
                        self.musicTerms += musicTerms
                        completion() // Call the completion handler when data loading is completed
                    }
                } catch {
                    // Handle error loading or parsing music dictionary data
                    print("Error loading or parsing music dictionary data: \(error)")
                }
            }
            
            // Start the URLSession task
            task.resume()
        }
    }


    // MARK: - Module navigation methods

    func beginModule(_ moduleid:Int) {
        // Find the index for this module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }

    func beginLesson(_ lessonIndex:Int) {
        // Check that the lesson index is within range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
    }

    func nextLesson() {
        // Advance the lesson index
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }

    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }

    func beginTest(_ moduleId:Int) {
        // Set the current module
        beginModule(moduleId)
        
        // Set the current question index
        currentQuestionIndex = 0
        
        // If there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0  > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
        }
    }

    func nextQuestion() {
        // Advance the question index
        currentQuestionIndex += 1
        
        // Check that it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            // Set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
        }
        else {
            // If not, then reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
}
