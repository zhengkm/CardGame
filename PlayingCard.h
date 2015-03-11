//
//  PlayingCard.h
//  CardGame
//
//  Created by zhengkaiming on 10/30/14.
//  Copyright (c) 2014 zhengkaiming. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
