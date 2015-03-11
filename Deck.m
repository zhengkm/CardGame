//
//  Deck.m
//  CardGame
//
//  Created by zhengkaiming on 10/29/14.
//  Copyright (c) 2014 zhengkaiming. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;//of Card
@end
@implementation Deck

//the place to put this needed heap allocation is in the getter for the cards property
-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];//all properties start out with a value of 0
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    }
    else{
        [self.cards addObject:card];
    }
}

- (void)addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard =nil;
    if([self.cards count]){
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
    
}

@end
