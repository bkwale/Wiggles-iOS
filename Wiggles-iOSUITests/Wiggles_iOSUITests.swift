//
//  Wiggles_iOSUITests.swift
//  Wiggles-iOSUITests
//
//  Created by Wale Koleosho on 01/10/2025.
//

import XCTest

final class Wiggles_iOSUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Stop immediately when a failure occurs
        continueAfterFailure = false
        
        // Initialize the app
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Clean up after each test
        app = nil
    }
    
    // MARK: - Test 1: App Launch and List Display
    
    func testAppLaunchesSuccessfullyAndDisplaysPuppyList() throws {
        // Verify the app exists and has launched
        XCTAssertTrue(app.exists, "App should launch successfully")
        
        // Verify the welcome header is displayed
        let welcomeText = app.staticTexts["Hey Sameer,"]
        XCTAssertTrue(welcomeText.exists, "Welcome header 'Hey Sameer,' should be displayed")
        
        // Verify the subtitle is displayed
        let subtitleText = app.staticTexts["Adopt a new friend near you!"]
        XCTAssertTrue(subtitleText.exists, "Subtitle 'Adopt a new friend near you!' should be displayed")
        
        // Verify "Nearby results" header is displayed
        let nearbyResultsHeader = app.staticTexts["Nearby results"]
        XCTAssertTrue(nearbyResultsHeader.exists, "'Nearby results' header should be displayed")
        
        // Verify at least one puppy card is displayed
        // Look for puppy names as a proxy for cards being displayed
        let parkinsonName = app.staticTexts["Parkinson"]
        XCTAssertTrue(parkinsonName.exists, "At least one puppy card (Parkinson) should be displayed")
    }
    
    // MARK: - Test 2: Navigation to Detail Page
    
    func testTappingPuppyCardNavigatesToDetailPage() throws {
        // Wait for the list to load
        let parkinsonCard = app.staticTexts["Parkinson"]
        XCTAssertTrue(parkinsonCard.waitForExistence(timeout: 5), "Parkinson card should exist")
        
        // Tap on the first puppy card (Parkinson)
        parkinsonCard.tap()
        
        // Wait a moment for navigation to complete
        sleep(1)
        
        // Verify we're on the detail page by checking for detail-specific elements
        // The puppy name should still be visible
        let detailPageName = app.staticTexts["Parkinson"]
        XCTAssertTrue(detailPageName.exists, "Puppy name should be displayed on detail page")
        
        // Verify "My Story" section header is displayed
        let myStoryHeader = app.staticTexts["My Story"]
        XCTAssertTrue(myStoryHeader.exists, "'My Story' section should be displayed on detail page")
        
        // Verify "Quick Info" section header is displayed
        let quickInfoHeader = app.staticTexts["Quick Info"]
        XCTAssertTrue(quickInfoHeader.exists, "'Quick Info' section should be displayed on detail page")
        
        // Verify detail page shows the puppy attributes
        let ageAndTemperament = app.staticTexts["2 yrs | Playful"]
        XCTAssertTrue(ageAndTemperament.exists, "Age and temperament should be displayed on detail page")
    }
    
    // MARK: - Test 3: Back Navigation
    
    func testBackNavigationReturnsToListingPage() throws {
        // Navigate to detail page first
        let parkinsonCard = app.staticTexts["Parkinson"]
        XCTAssertTrue(parkinsonCard.waitForExistence(timeout: 5), "Parkinson card should exist")
        parkinsonCard.tap()
        
        // Wait for detail page to load
        let myStoryHeader = app.staticTexts["My Story"]
        XCTAssertTrue(myStoryHeader.waitForExistence(timeout: 5), "Detail page should load")
        
        // Find and tap the back button
        // Back buttons in iOS are typically the first button in the navigation bar
        let backButton = app.buttons["backButton"]
        XCTAssertTrue(backButton.exists, "Back button should exist")
        backButton.tap()
        
        // Wait a moment for navigation to complete
        sleep(1)
        
        // Verify we're back on the listing page
        let nearbyResultsHeader = app.staticTexts["Nearby results"]
        XCTAssertTrue(nearbyResultsHeader.exists, "Should return to listing page with 'Nearby results' header")
        
        // Verify the welcome header is visible again
        let welcomeText = app.staticTexts["Hey Sameer,"]
        XCTAssertTrue(welcomeText.exists, "Welcome header should be visible after back navigation")
        
        // Verify puppy cards are displayed again
        let parkinsonCardAgain = app.staticTexts["Parkinson"]
        XCTAssertTrue(parkinsonCardAgain.exists, "Puppy cards should be displayed after back navigation")
    }
    
    // MARK: - Bonus Test 4: Multiple Puppy Cards Display
    
    func testMultiplePuppyCardsAreDisplayed() throws {
        // Verify multiple different puppies are shown in the list
        let parkinson = app.staticTexts["Parkinson"]
        let miloMan = app.staticTexts["MiloMan"]
        let daisy = app.staticTexts["Daisy"]
        
        XCTAssertTrue(parkinson.exists, "Parkinson should be displayed")
        XCTAssertTrue(miloMan.exists, "MiloMan should be displayed")
        XCTAssertTrue(daisy.exists, "Daisy should be displayed")
    }
}
