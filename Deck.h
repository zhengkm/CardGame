//
//  Deck.h
//  CardGame
//
//  Created by zhengkaiming on 10/29/14.
//  Copyright (c) 2014 zhengkaiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;
@end
