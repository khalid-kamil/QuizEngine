//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Khalid Kamil on 11/06/2023.
//
import Foundation
import XCTest
@testable import QuizEngine

final class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2() {
        let sut = makeSUT(questions: ["Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_routesToSecondQuestion() {
        let sut = Flow(questions: ["Q1", "Q2"], router: router)

        sut.start()
        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    // MARK: Helpers
    func makeSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions = [String]()
        var answerCallback: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }

}
