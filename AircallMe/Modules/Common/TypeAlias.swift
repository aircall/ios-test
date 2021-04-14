//
//  TypeAlias.swift
//  Common
//
//  Created by Rudy Frémont on 10/04/2021.
//

import Foundation

/// typealias for common completion handler with generic type
public typealias CompletionHandler<T> = (Result<T, HTTPStatusCode>) -> Void
