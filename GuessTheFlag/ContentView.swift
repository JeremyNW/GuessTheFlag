//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jeremy Warren on 3/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var guesses = 8
    @State private var points = 0
    @State private var gameOver = false
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .gray]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag!")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
                Text("Score: \(points)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                Spacer()
            }
            
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message : {
            Text("Your score is \(points)")
        }
        .alert("Your final score is \(points)!", isPresented: $gameOver) {
            Button("Reset Game", action: resetGame)
        } message: {
            Text("Reset Game")
        }
    }
    func flagTapped(_ number: Int) {
        guesses -= 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            points += 1
        } else {
            scoreTitle = "Wrong, that country is \(countries[number])!"
        }
        showingScore = true
        if guesses == 0 {
            gameOver = true
        }
        
    }
    func askQuestion() {
        guard guesses > 0 else { return }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        points = 0
        guesses = 8
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
