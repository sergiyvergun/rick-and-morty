//
//  CharactersViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Sergiy Vergun on 25/04/2024.
//

import XCTest
@testable import RickAndMorty

class CharactersViewModelTests: XCTestCase {
    
    var viewModel: CharactersViewModel!
    
    override func setUpWithError() throws {
        viewModel = CharactersViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testFetchCharacters() async {
        await viewModel.fetchCharacters(page: 1)
        DispatchQueue.main.sync{
            XCTAssertFalse(self.viewModel.characters.isEmpty, "Characters should be fetched")
            XCTAssertEqual(self.viewModel.fetchState, .initial, "Fetch state should be initial after successful fetch")
            }
    }
    
    func testFetchMoreCharacters() async throws {
        let initialCharacterCount = viewModel.characters.count
        await viewModel.fetchMoreCharacters()
        XCTAssertTrue(viewModel.characters.count > initialCharacterCount, "More characters should be fetched")
    }
    
}

