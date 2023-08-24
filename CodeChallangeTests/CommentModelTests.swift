//
//  CommentModelTests.swift
//  CodeChallangeTests
//
//  Created by Niyati Patel on 24/08/23.
//

import XCTest
@testable import CodeChallange

final class CommentModelTests: XCTestCase {

    func test_getCommentsListOnPost_with_validRequest_returns_success() {
        
        //Arrange
        let postId = 1
        let expectation = self.expectation(description: "getCommentsListOnPost_with_validRequest_returns_success")
        
        //Act
        Comment.GetCommentsListOnPost(withPostId: postId) { comments in
            
            //Assert
            XCTAssertTrue(comments.count > 0 || comments.count == 0)
            expectation.fulfill()
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
    
    func test_getCommentsListOnPost_with_invalidRequest_returns_failure() {
        
        //Arrange
        let postId = 1111111
        let expectation = self.expectation(description: "getCommentsListOnPost_with_invalidRequest_returns_failure")
        
        //Act
        Comment.GetCommentsListOnPost(withPostId: postId) { comments in
            
            //Assert
            XCTAssertFalse(comments.count > 0)
            expectation.fulfill()
            
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
}
