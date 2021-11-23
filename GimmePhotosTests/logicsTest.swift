//
//  CopyFileWorkerTests.swift
//  GimmePhotosTests
//
//  Created by user on 20/11/2021.
//

import Foundation
import XCTest
@testable import GimmePhotos

class CopyFileWorkerTests: XCTestCase {
    func testGuessingFileNames() {
        let fileNames = ["IMG_02302.jpg","IMG_02303.jpg","IMG_121.raw"]
        let guessedFiles = guessWhichFiles( fileNames, "302, 121")
        XCTAssertEqual(guessedFiles["302"], "IMG_02302.jpg")
        XCTAssertEqual(guessedFiles["121"], "IMG_121.raw")
    }
    
    func testGuessingFileNames_OtherSeparators() {
        let fileNames = ["IMG_02302.jpg","IMG_02303.jpg","IMG_121.raw"]
        let guessedFiles = guessWhichFiles( fileNames, "302,; 121")
        XCTAssertEqual(guessedFiles["302"], "IMG_02302.jpg")
        XCTAssertEqual(guessedFiles["121"], "IMG_121.raw")
    }
    
    func testGuessingFileNames_SpaceSeparatorOk() {
        let fileNames = ["IMG_02302.jpg","IMG_02303.jpg","IMG_121.raw"]
        let guessedFiles = guessWhichFiles( fileNames, "302 121")
        XCTAssertEqual(guessedFiles["302"], "IMG_02302.jpg")
        XCTAssertEqual(guessedFiles["121"], "IMG_121.raw")
    }
    
    func testGuessingFileNames_LowerNumberMoreImportant() {
        let fileNames = ["IMG_3021.jpg","IMG_3302.jpg"]
        let guessedFiles = guessWhichFiles( fileNames, "302")
        XCTAssertEqual(guessedFiles["302"], "IMG_3302.jpg")
    }
    
        func testGuessingFileNames_ComplexCase_StrongMatchWins() {
            let fileNames = ["IMG_3021.jpg","IMG_3302.jpg"]
            let guessedFiles = guessWhichFiles( fileNames,"330, 302")
            XCTAssertEqual(guessedFiles["302"], "IMG_3302.jpg")
            let nilString: String? = nil
            XCTAssertEqual(guessedFiles["330"], nilString)
        }
    
    func testGuessingFileNames_30202() {
        let fileNames = ["IMG_3302.jpg", "IMG_4402.jpg"]
        let guessedFiles = guessWhichFiles( fileNames,"02, 302")
        XCTAssertEqual(guessedFiles["302"], "IMG_3302.jpg")
        XCTAssertEqual(guessedFiles["02"], "IMG_4402.jpg")
        
    }
    
    func testGuessingFileNames_LettersAreIgnored() {
        let fileNames = ["IMG_3302.jpg"]
        let guessedFiles = guessWhichFiles( fileNames, "302s")
        XCTAssertEqual(guessedFiles["302"], "IMG_3302.jpg")
    }
}
