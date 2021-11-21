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
    var fileNamesFromUser = fileInputFromUser
        .split(separator: ",")
        .map { $0.trimmingCharacters(in: .whitespaces)}
    var result = findEasyMatches(fileNamesFromUser: fileNamesFromUser, filesInSrcDirectory: fileNames)
    fileNamesFromUser.removeAll{result.keys.contains($0)}
    for fileName in result.values.compactMap({ $0 }) {
        fileNames.remove(fileName)
    }
    
    for fileNameFromUser in fileNamesFromUser {
        result[fileNameFromUser] = nil as String?
        if let candidate = findBestCandidate(candidates: fileNames, nameInput: fileNameFromUser){
            result[fileNameFromUser] = candidate
            fileNames.remove(candidate)
        }
    }
    return result
}

private func findEasyMatches(fileNamesFromUser: [String], filesInSrcDirectory: Set<String>) -> [String:String?]{
    var result: [String:String] = [:]
    for fileNameFromUser in fileNamesFromUser {
        if Int(fileNameFromUser) != nil {//so only digits in input
            if let easyMatch = filesInSrcDirectory.first(where: { $0.onlyDigits().suffix(fileNameFromUser.count) == fileNameFromUser}) {
                result[fileNameFromUser] = easyMatch
            }
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
