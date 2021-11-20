//
//  CopyFileWorker.swift
//  GimmePhotos
//
//  Created by user on 20/11/2021.
//

import Foundation

func copy(from: String, to: String, fileInputFromUser: String) throws {
    let fileManager = FileManager.default
    let filesInSrcDirectory = try fileManager.contentsOfDirectory(atPath: from)
    
    let filesToCopy = guessWhichFiles(filesInSrcDirectory, fileInputFromUser)
    for fileToCopy in filesToCopy {
        let srcFile = from + "/" + fileToCopy
        print("copying \(srcFile)")
        try fileManager.copyItem(at: URL(fileURLWithPath: srcFile), to: URL(fileURLWithPath: to))
        
    }
}

func guessWhichFiles(_ filesInSrcDirectory: [String], _ fileInputFromUser: String) -> [String]{
    var fileNames = Set(filesInSrcDirectory)
    var result: [String] = []
    
    let fileNamesFromUser = fileInputFromUser
        .split(separator: ",")
        .map { $0.trimmingCharacters(in: .whitespaces)}
    
    for fileNameFromUser in fileNamesFromUser {
        if let candidate = findBestCandidate(candidates: fileNames, nameInput: fileNameFromUser){
            result.append(candidate)
            fileNames.remove(candidate)
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
extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
}
