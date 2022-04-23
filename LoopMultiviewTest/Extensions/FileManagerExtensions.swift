//
//  FileManagerExtensions.swift
//  LoopMultiviewTest
//
//  Created by Joey Rubin on 4/23/22.
//

import Foundation
import FileProvider

extension FileManager {
    
    enum FileExtension: String{
        
        case m4a = ".m4a"
    }
    
    func getFileURL(name: String, fileExtension: FileExtension ) -> URL {
        
        let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
            FileManager.SearchPathDomainMask.userDomainMask).first
        
        let audioFileName = name + fileExtension.rawValue
        let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
        
        return audioFileURL
    }
}
