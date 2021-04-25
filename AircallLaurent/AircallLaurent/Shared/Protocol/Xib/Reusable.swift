//
//  Reusable.swift
//  AircallLaurent
//
//  Created by Laurent on 24/04/2021.

import Foundation

/*******************************************************************************
 * Reusable
 *
 * A reusable type that can be identified with a string.
 *
 ******************************************************************************/

protocol Reusable {
  static var reuseIdentifier: String { get }
}

extension Reusable {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}
