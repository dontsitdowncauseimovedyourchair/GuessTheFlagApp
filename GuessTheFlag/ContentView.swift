//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Alejandro González on 19/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore: Bool = false
    @State private var score: Int = 0
    @State private var clickedFlag: String = ""
    
    @State private var alertMessage: String = ""
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer: Int = Int.random(in: 0...3)
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                RadialGradient(stops: [
                    .init(color: .red, location: 0.3),
                    .init(color: .white, location: 0.3),
                    .init(color: Color(red: 0.9, green: 0.9, blue: 0.9), location: 1)
                ], center: .top, startRadius: 260, endRadius: 270)
                RadialGradient(stops: [
                    .init(color: .red, location: 0.3),
                    .init(color: .white, location: 0.3),
                    .init(color: Color(red: 0.9, green: 0.9, blue: 0.9), location: 1)
                ], center: .bottom, startRadius: 260, endRadius: 270)
            }
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle .bold())
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                
                Spacer()
                
                VStack(spacing: 40) {
                    VStack {
                        Text("Select the flag for")
                            .font(.headline .weight(.medium))
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle .weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    VStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(for: number)
                            } label: {
                                Image(countries[number])
                            }
                            .shadow(radius: 10)
                            .clipShape(.capsule)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,25)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title .bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(alertMessage, isPresented: $showingScore) {
            Button("Next") {
                updateGame()
            }
        } message: {
            Text(!clickedFlag.isEmpty ? "That's the \(clickedFlag) flag" : "")
        }
        .ignoresSafeArea()
    }
    
    func flagTapped(for number: Int) {
        if (number == correctAnswer) {
            score += 1
            alertMessage = "You're right!!!"
            clickedFlag = ""
        } else {
            score -= 1
            alertMessage = "You're Mr. Flop"
            clickedFlag = countries[number]
        }
        showingScore = true
    }
    
    func updateGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
    }
}

#Preview {
    ContentView()
}
