//
//  ContentView.swift
//  GuessTheFlag-WHS-P2
//
//  Created by Ade Dwi Prayitno on 27/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var rotationAngle = [Double](repeating: 0.0, count: 3)
    @State private var opacityAmount = [Double](repeating: 1.0, count: 3)
    @State private var scaleAmount = [Double](repeating: 1.0, count: 3)
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                                   .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                                VStack {
                                    Text("Tap the flag of")
                                        .largeBlueTitle()
                                    
                                    Text(countries[correctAnswer])
                                        .font(.largeTitle.weight(.semibold))
                                }
                                
                                ForEach(0..<3){ number in
                                    Button {
                                        flagTapped(number)
                                        withAnimation {
                                            rotationAngle[number] += 360
                                            for button in 0..<3 where button != number {
                                                opacityAmount[button] = 0.25
                                                scaleAmount[button] = 0.85
                                            }
                                        }
                                    } label: {
                                        FlagImage(image: countries[number])
                                    }
                                    .opacity(opacityAmount[number])
                                    .scaleEffect(scaleAmount[number])
                                    .rotation3DEffect(.degrees(rotationAngle[number]), axis: (x: 0, y: 1, z: 0))
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(.regularMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if(userScore == 8) {
                Button("Restart", action: restartGame)
            } else {
                Button("Continue", action: askQuestion)
            }
            
        } message: {
            Text("Your score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if(number == correctAnswer) {
            scoreTitle = userScore == 7 ? "Congratulations you have successfully completed the question" : "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func restartGame() {
        userScore = 0
        countries.shuffle()
        rotationAngle = [Double](repeating: 0.0, count: 3)
        opacityAmount = [Double](repeating: 1.0, count: 3)
        scaleAmount = [Double](repeating: 1.0, count: 3)
        correctAnswer = Int.random(in: 0...2)
    }
    
    func askQuestion() {
        countries.shuffle()
        rotationAngle = [Double](repeating: 0.0, count: 3)
        opacityAmount = [Double](repeating: 1.0, count: 3)
        scaleAmount = [Double](repeating: 1.0, count: 3)
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
