//
//  LoginBLUnitTests.swift
//  CodeChallangeTests
//
//  Created by Niyati Patel on 24/08/23.
//

import XCTest
@testable import CodeChallange

final class LoginBLUnitTests: XCTestCase {
    let loginVC = LoginVC()

    //MARK: - UserId Validations
    func test_LoginValidation_With_EmptyString_Returns_ValidationFailure() {

        //Arrange
        let userId = ""

        //Act
        let result = loginVC.isValidUserInput(input: userId)
        
        //Assert
        XCTAssertFalse(result)

    }

    func test_LoginValidation_With_CharacterInUserId_Returns_ValidationFailure() {

        //Arrange
        let userId = "ABC"

        //Act
        let result = loginVC.isValidUserInput(input: userId)
        
        //Assert
        XCTAssertFalse(result)

    }
    
    func test_LoginValidation_With_InvalidUserId_Returns_ValidationFailure() {

        //Arrange
        let userId = "123456"

        //Act
        let result = loginVC.isValidUserInput(input: userId)
        
        //Assert
        XCTAssertFalse(result)

    }
    
    func test_LoginValidation_With_UserId_Including_Space_Returns_ValidationFailure() {

        //Arrange
        let userId = "1234 "

        //Act
        let result = loginVC.isValidUserInput(input: userId)
        
        //Assert
        XCTAssertFalse(result)

    }
    
    func test_LoginValidation_With_ValidUserId_Returns_Success() {

        //Arrange
        let userId = "1"

        //Act
        let result = loginVC.isValidUserInput(input: userId)
        
        //Assert
        XCTAssertTrue(result)

    }
    
}
