//
//  File.swift
//  
//
//  Created by Jobert on 22/06/2021.
//

import Foundation

/**
 Stores information about a file.
 */
public struct FileDescription {

    /// The file's name.
    public let name: String
    /// The file's extension.
    public let `extension`: String

    /**
     Creates an instance of `FileDescription` with the given name and extension.
     - Parameters:
        - name: The file's name.
        - extension: The file's extension.
     - Returns: An instance of `FileDescription`
     */
    init?(name: String, extension: String) {
        guard name != CommonConstants.emptyString,
              `extension` != CommonConstants.emptyString else {
            return nil
        }
        self.name = name
        self.extension = `extension`
    }

    /**
     Creates an instance of `FileDescription` with extension *json*.
     - Parameters:
        - name: The file's name.
     - Returns: An instance of `FileDescription`.
     */
    public static func json(with name: String) -> FileDescription? {
        FileDescription(name: name, extension: CommonConstants.jsonExtension)
    }
}
