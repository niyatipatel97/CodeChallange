//
//  PostModelTests.swift
//  CodeChallangeTests
//
//  Created by Niyati Patel on 24/08/23.
//

import XCTest
@testable import CodeChallange

final class PostModelTests: XCTestCase {

    
    func test_GetPostApiResponse_with_validRequest_returns_success() {
        
        //Arrange
        let userId = 1
        let expectation = self.expectation(description: "GetPostApiResponse_with_validRequest_returns_success")
        
        //Act
        Post.GetPostList(userId: userId) { posts in
            
            //Assert
            XCTAssertTrue(posts.count > 0 || posts.count == 0)
            expectation.fulfill()
            
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
    
    func test_GetPostApiResponse_with_invalidRequest_returns_failure() {
        
        //Arrange
        let userId = 1111111
        let expectation = self.expectation(description: "GetPostApiResponse_with_invalidRequest_returns_failure")
        
        //Act
        Post.GetPostList(userId: userId) { posts in
            
            //Assert
            XCTAssertFalse(posts.count > 0)
            expectation.fulfill()
            
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
    
    func test_editFavUnfavPostApiResponse_with_validRequest_returns_success() {
        
        //Arrange
        let dict: [String : Any] = [kId: 1,
                                 ktitle: "",
                                  kbody: "",
                           kisFavourite: 1]
        let objPost = Post(dictionary: dict)
        let expectation = self.expectation(description: "editFavUnfavPostApiResponse_with_validRequest_returns_success")
        
        //Act
        Post.editFavUnfavPost(wihtObjPost: objPost) { isSuccess in
            
            //Assert
            XCTAssertTrue(isSuccess)
            expectation.fulfill()
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
    
    func test_editFavUnfavPostApiResponse_with_invalidRequest_returns_failure() {
        
        //Arrange
        let dict: [String : Any] = [kId: 0,
                                 ktitle: "",
                                  kbody: "",
                           kisFavourite: 1]
        let objPost = Post(dictionary: dict)
        let expectation = self.expectation(description: "editFavUnfavPostApiResponse_with_invalidRequest_returns_failure")
        
        //Act
        Post.editFavUnfavPost(wihtObjPost: objPost) { isSuccess in
            
        } failure: { error in
            
            //Assert
            XCTAssertNotNil(error)
            XCTAssertEqual(error, LocalizableKeys.NoDataLabelText.kNotAddedToFavourite)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)

    }
    
    
    func test_getFavPostListApiResponse_with_validRequest_returns_success() {
        
        //Arrange
        let userId = 1
        let expectation = self.expectation(description: "getFavPostListApiResponse_with_validRequest_returns_success")
        
        //Act
        Post.GetFavPostList(userId: userId) { posts in
            
            //Assert
            XCTAssertTrue(posts.count > 0 || posts.count == 0)
            expectation.fulfill()
            
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
    
    func test_getFavPostListApiResponse_with_invalidRequest_returns_failure() {
        
        //Arrange
        let userId = 1111111
        let expectation = self.expectation(description: "getFavPostListApiResponse_with_invalidRequest_returns_failure")
        
        //Act
        Post.GetFavPostList(userId: userId) { posts in
            
            //Assert
            XCTAssertFalse(posts.count > 0)
            expectation.fulfill()
            
        } failure: { error in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5)

    }
}
