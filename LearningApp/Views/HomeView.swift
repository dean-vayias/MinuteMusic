//
//  ContentView.swift
//  LearningApp
//
//  Created by Dean Vayias on 2023-04-22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("This won't take too long!")
                    .padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) { module in
                            VStack(spacing: 20) {
                                NavigationLink(destination: ContentView().onAppear(perform: {
                                    model.beginModule(module.id)
                                }), tag: module.id, selection: $model.currentContentSelected) {
                                    HomeViewRow(image: module.content.image, title: "\(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons")
                                }
                                NavigationLink(destination: TestView().onAppear(perform: {
                                    model.beginTest(module.id)
                                }), tag: module.id, selection: $model.currentTestSelected) {
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Quiz", description: module.test.description, count: "\(module.test.questions.count) Lessons")
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
            }
            .navigationTitle("Start Learning")
            .onChange(of: model.currentContentSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
        }
        .navigationViewStyle(.stack)
        .padding(.horizontal, 10)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
