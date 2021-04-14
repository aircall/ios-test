//
//  CommonTests.swift
//  CommonTests
//
//  Created by Rudy Frémont on 10/04/2021.
//

import XCTest
@testable import Common

/// Helpers for tests

struct TestDateString: Codable {
    var date: String?
    enum CodingKeys: String, CodingKey {
        case date
    }
}

struct TestDatePropertyWrapper: Codable {
    @ISO8601DateFormatted var date: Date?
    enum CodingKeys: String, CodingKey {
        case date
    }
}

/// Property wrapper to encode a nil value by using "null" keyword in the generated data JSON
@propertyWrapper
struct NullEncodable<T>: Encodable where T: Encodable {
    
    var wrappedValue: T?

    init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch wrappedValue {
        case .some(let value): try container.encode(value)
        case .none: try container.encodeNil()
        }
    }
}

struct TestNull: Encodable {
    @NullEncodable var date: String?
}

class CommonTests: XCTestCase {

    func testDecodeWithISO8601DateFormattedSuccess() throws {
        
        let testIn = try XCTUnwrap(TestDateString(date: "2018-04-18T16:59:48.000Z").encode(), "Cannot encode TestDateString")
        let test = try? TestDatePropertyWrapper.decode(data: testIn)
        XCTAssertNotNil(test?.date, "Decode ISO8601DateFormatted not OK")

        //Extra test for date formatter
        XCTAssertEqual(test?.date?.timeShort(), "6:59 PM")
        XCTAssertEqual(test?.date?.dayMonth(), "Apr 18")
    }
    
    func testEncodeWithISO8601DateFormattedSuccess() throws {
        //Inverse
        let testIn = try XCTUnwrap(TestDatePropertyWrapper(date: Date()).encode(), "Cannot encode TestDatePropertyWrapper")
        let test = try? TestDateString.decode(data: testIn)
        print(test.debugDescription)
        XCTAssertNotNil(test?.date, "Encode ISO8601DateFormatted not OK")
    }
    
    func testDecodeWithISO8601DateFormattedNull() throws {
        //Error case for decode
        
        let testInError = try XCTUnwrap(TestNull().encode(), "Cannot encode TestNull")
        let test = try? TestDatePropertyWrapper.decode(data: testInError)
        XCTAssertNil(test?.date, "Possible to decode null value ??")
    }
    func testEncodeWithISO8601DateFormattedNull() throws {
        //Error case for encode
        let testIn = try XCTUnwrap(TestDatePropertyWrapper(date: nil).encode(), "Cannot encode TestDatePropertyWrapper")
        let test = try? TestDateString.decode(data: testIn)
        XCTAssertNil(test?.date, "Possible to decode empty data ??")
    }

}
