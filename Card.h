//
//  Card.h
//  CardGame
//
//  Created by zhengkaiming on 10/29/14.
//  Copyright (c) 2014 zhengkaiming. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (NSArray *)matchHistory;
- (int)match:(NSArray *)otherCards;

@end
