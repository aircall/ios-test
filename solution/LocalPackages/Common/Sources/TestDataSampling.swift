//
//  TestDataSampling.swift
//  
//
//  Created by Jobert on 28/06/2021.
//

import Foundation

/**
 Defines helper methods to handle test data samples.
 */
protocol TestDataSampling: AnyObject { }

extension TestDataSampling {

    /**
     Gets a sample data for tests purposes.
     - Parameters:
        - file: The description of the file containing the samples.
        - bundle: The bundle which contains the file
     - Returns: An instance of `Data` containing the contents of the sample.
     */
    func getSampleData(from file: FileDescription, in bundle: Bundle) -> Data? {
        guard let url = bundle.url(forResource: file.name, withExtension: file.extension),
              let data = try? Data(contentsOf: url) else {
            print("Could not find sample file: \(file.name).\(file.extension)")
            return nil
        }
        return data
    }
}
