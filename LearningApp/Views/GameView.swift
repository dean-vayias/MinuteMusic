//
//  GameView.swift
//  MinuteMusic
//
//  Created by Dean Vayias on 12/20/23.
//

import SwiftUI

struct GameView: View {
    
    @State private var playerCard = "note1"
    @State private var cpuCard = "note1"
    @State private var playerScore = 0
    @State private var cpuScore = 0
    
    // Explicit list of numbers
    let randomNumberList = [1,11,111,1111,11111111,2,22,222,2222,22222222,3,33,333,3333,33333,333333,3333333,33333333,4]

    var body: some View {
        ZStack {
            Image("background").ignoresSafeArea()
            VStack {
                Spacer()
                Image("logo")
                Text("Tap the \"DUEL\" button and compare\n your total beat value with the\n opponent's - the greater value wins!").multilineTextAlignment(.center)
                Spacer()
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    // Update cards and score
                    playerCard = generateFileName()
                    cpuCard = generateFileName()
                    
                    if let playerDigit = extractLastDigit(from: playerCard),
                       let cpuDigit = extractLastDigit(from: cpuCard) {
                        
                        if playerDigit > cpuDigit {
                            playerScore += 1
                        } else if cpuDigit > playerDigit {
                            cpuScore += 1
                        }
                    }
                }, label: {
                    Image("dealbutton")
                })
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(playerScore))
                            .font(.largeTitle)
                    }.foregroundColor(Color.black)
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text(String(cpuScore))
                            .font(.largeTitle)
                    }.foregroundColor(Color.black)
                    Spacer()
                }
                Spacer()
            }
        }
        .padding(.horizontal, 20)
    }
    
    func generateFileName() -> String {
        // Generate your file names here based on your explicit list
        let randomValue = randomNumberList.randomElement() ?? 1
        return "note" + String(randomValue)
    }
    
    func extractLastDigit(from fileName: String) -> Int? {
        // Extract the last digit from the file name
        if let lastCharacter = fileName.last,
           let digit = Int(String(lastCharacter)) {
            return digit
        }
        return nil
    }
}



struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
