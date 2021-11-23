//
//  CopyFileWorker.swift
//  GimmePhotos
//
//  Created by user on 20/11/2021.
//

import Foundation


func copy(from: String, to: String, fileInputFromUser: String) throws -> [String:String?] {
    let fileManager = FileManager.default
    let filesInSrcDirectory = try fileManager.contentsOfDirectory(atPath: from)
    
    let filesToCopy = guessWhichFiles(filesInSrcDirectory, fileInputFromUser)
    for fileToCopy in filesToCopy.values.compactMap({$0}) {
        let srcFile = from + "/" + fileToCopy
        let toFile = to + "/" + fileToCopy
        print("copying \(srcFile)")
        try fileManager.copyItem(at: URL(fileURLWithPath: srcFile), to: URL(fileURLWithPath: toFile))
        
    }
    return filesToCopy
}

func guessWhichFiles(_ filesInSrcDirectory: [String], _ fileInputFromUser: String) -> [String:String?]{
    var fileNames = Set(filesInSrcDirectory)
    var fileNumbersFromUser = getNumbers(string: fileInputFromUser)
    var result = findEasyMatches(fileNumbersFromUser: fileNumbersFromUser, filesInSrcDirectory: fileNames)
    fileNumbersFromUser.removeAll{result.keys.contains($0)}
    for fileName in result.values.compactMap({ $0 }) {
        fileNames.remove(fileName)
    }
    
    for fileNameFromUser in fileNumbersFromUser {
        result[fileNameFromUser] = nil as String?
    }
    return result
}

private func getNumbers(string: String) -> [String] {
    let regex = try! NSRegularExpression(pattern: "\\d+")
    let range = NSRange(location: 0, length: string.utf16.count)
    return regex.matches(in: string, options: [], range: range)
        .map {String(string[Range($0.range, in: string)!])}
}

private func findEasyMatches(fileNumbersFromUser: [String], filesInSrcDirectory: Set<String>) -> [String:String?]{
    var result: [String:String] = [:]
    var candidateFiles = filesInSrcDirectory
    for fileNoFromUser in fileNumbersFromUser.sorted(by: {$0.count >= $1.count }) {
        if let easyMatch = candidateFiles.first(where: { $0.onlyDigits().suffix(fileNoFromUser.count) == fileNoFromUser}) {
            result[fileNoFromUser] = easyMatch
            candidateFiles.remove(easyMatch)
        }
    }
    return result
}

private func findBestCandidate(candidates: Set<String>, nameInput: String) -> String?{
    return candidates
        .filter{$0.contains(nameInput)}
        .sorted { $0.range(of: nameInput)!.lowerBound > $1.range(of: nameInput)!.lowerBound}
        .first
}
extension String {
    func isDirectory() -> Bool {
        let fileManager = FileManager.default
        var isDir : ObjCBool = false
        if fileManager.fileExists(atPath: self, isDirectory: &isDir) {
            if isDir.boolValue {
                return true
            }
        }
        return false
    }
    func onlyDigits() -> String {
        return self.filter { $0.isNumber }
    }
}
