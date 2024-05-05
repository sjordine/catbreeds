//
//  CatServicesTest.swift
//  CatBreedsTests
//
//  Created by Sergio Ordine on 05/05/24.
//

import XCTest
@testable import CatBreeds

final class CatServicesTest: XCTestCase {
    
    var targetCatServiceTest = CatServices()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mockedDatabase = CatCountryDatabaseMock()
        targetCatServiceTest.catBreedDatabase = mockedDatabase
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCountriesFormatting() throws {
        let expectation = XCTestExpectation(description: "Retrieve breed databse asynchronously")
        
        Task {
            do {
                let breedResult = try await targetCatServiceTest.retrieveCatBreeds()
                let countriesList = breedResult.map { catBreed in
                    catBreed.country
                }
                XCTAssertEqual(countriesList, ["Botswana","Saudi Arabia","Hungary","United Arab Emirates"], "Country list not matches the expected one")
                let countyCodes = breedResult.map { catBreed in
                    catBreed.countryCode
                }
                XCTAssertEqual(countyCodes, ["BW","SA","HU","AE"], "Country list not matches the expected one")
                expectation.fulfill()
            } catch {
                XCTFail("Error processing cat breed \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
