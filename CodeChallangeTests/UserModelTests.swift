//
//  UserModelTests.swift
//  CodeChallangeTests
//
//  Created by Niyati Patel on 24/08/23.
//

import XCTest
@testable import CodeChallange

final class UserModelTests: XCTestCase {
    
    //MARK: - Login Api
    func test_LoginApiResponse_with_validRequest_returns_success() {
        
        //Arrange
        let userId = 1
        let expactation = self.expectation(description: "validRequest_returns_success")
        
        //Act
        User.LoginApi(withUserId: userId) { user in
            
            //Assert
            XCTAssertNotNil(user)
            XCTAssertEqual(userId, user.userId)
            expactation.fulfill()
            
        } failure: { error in
            
            XCTAssertNil(error)
        }

        waitForExpectations(timeout: 5)
    }
    
    func test_LoginApiResponse_with_invalidRequest_returns_failure() {
        
        //Arrange
        let userId = 1111111
        let expactation = self.expectation(description: "invalidRequest_returns_failure")
        
        //Act
        User.LoginApi(withUserId: userId) { user in
            
            XCTAssertNil(user)
            
        } failure: { error in
            
            //Assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error, LocalizableKeys.NoDataLabelText.kNoUserFound)
            expactation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

}
