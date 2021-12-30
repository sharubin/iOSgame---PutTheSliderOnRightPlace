//
//  Game.swift
//  right on target
//
//  Created by Artsem Sharubin on 30.12.2021.
//

import Foundation


protocol GameProtocol {
    var score: Int { get }
    var currentRound: GameRoundProtocol! { get }
    var isGameEnded: Bool { get }
    var secretValueGenerator: GeneratorProtocol { get }
    func restartGame()
    func startNewRound()
}

class Game: GameProtocol {
    var score: Int {
        var totalScore: Int = 0
        for round in self.rounds {
            totalScore += round.score
        }
        return totalScore
    }
    var currentRound: GameRoundProtocol!
    private var rounds: [GameRoundProtocol] = []
    var secretValueGenerator: GeneratorProtocol
    private var roundsCount: Int!
    var isGameEnded: Bool {
        if roundsCount == rounds.count {
            return true
        } else {
            return false
        }
    }

    init(valueGenerator: GeneratorProtocol, rounds: Int) {
        secretValueGenerator = valueGenerator
        roundsCount = rounds
        startNewRound()
    }
    
    func restartGame() {
        rounds = []
        startNewRound()
    }

    func startNewRound() {
        let newSecretValue = self.getNewSecretValue()
        currentRound = GameRound(secretValue: newSecretValue)
        rounds.append( currentRound )
    }

    // Загадать и вернуть новое случайное значение
    private func getNewSecretValue() -> Int {
        return secretValueGenerator.getRandomValue()
    }
}
