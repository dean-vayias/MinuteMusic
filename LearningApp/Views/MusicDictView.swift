//
//  MusicDictView.swift
//  MinuteMusic
//
//  Created by Dean Vayias on 1/1/24.
//

import SwiftUI

struct MusicDictView: View {
    @StateObject private var contentModel = ContentModel()
    @State private var searchText = ""
    
    // Filtered music terms based on the search text
    var filteredMusicTerms: [MusicTerm] {
        if searchText.isEmpty {
            return contentModel.musicTerms
        } else {
            return contentModel.musicTerms.filter { term in
                term.term.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                SearchBar(text: $searchText)
                
                ForEach(filteredMusicTerms) { term in
                    NavigationLink(destination: MusicTermDetailView(term: term)) {
                        Text(term.term)
                    }
                }
            }
            .navigationTitle("Music Dictionary")
        }
        .onAppear {
            // Load music dictionary data when the view appears
            contentModel.loadMusicDictData{
                
            }
        }
    }
}

struct MusicTermDetailView: View {
    var term: MusicTerm
    
    var body: some View {
        VStack {
            Text(term.term)
                .font(.title)
                .bold()
            Text(term.definition)
                .padding()
            Spacer()
        }
        .navigationTitle("")
    }
}

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

struct MusicDictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        MusicDictView()
    }
}
