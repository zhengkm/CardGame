//
//  ViewController.m
//  CardGame
//
//  Created by zhengkaiming on 10/29/14.
//  Copyright (c) 2014 zhengkaiming. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (nonatomic, strong) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControlButton;
@property (weak, nonatomic) IBOutlet UITextView *gameHistory;
@property (weak, nonatomic) IBOutlet UISlider *gameHistorySlider;

@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck { // abstract method
    return [[PlayingCardDeck alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateGameHistorySlider];
}

- (void)updateGameHistorySlider {
    int count =  (int) [[self.game matchHistory] count] - 1;
    self.gameHistorySlider.maximumValue = count;
    self.gameHistorySlider.value = self.gameHistorySlider.maximumValue;
    self.gameHistorySlider.enabled = (count > 1) ? YES : NO;
}

- (IBAction)slideThroughHistory {
    int element = (int) round(self.gameHistorySlider.value);
    if (element < 0) element = 0;
    
    // set text to display history
    NSArray *history = [[self.game matchHistory] objectAtIndex:element];
    self.gameHistory.text = [history componentsJoinedByString:@"\n"];
    
    // change text color when we're looking at the past
    if (element == self.gameHistorySlider.maximumValue) {
        self.gameHistory.textColor = [UIColor blackColor];
    } else {
        self.gameHistory.textColor = [UIColor redColor];
    }
}

- (IBAction)deal {
    // ask to confirm re-dealing
    UIAlertView *warning = [[UIAlertView alloc] initWithTitle:@"Re-deal"
                                                      message:@"Are you sure you want to re-deal the deck and start over?"
                                                     delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Yes", nil];
    [warning show];
}

// handle alert view confirmation
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
        [self reDeal];
    }
}

- (void)reDeal {
    // enable the game type segmented control
    self.gameTypeControlButton.enabled = YES;
    
    self.game = nil;
    self.game.gameType = self.gameTypeControlButton.selectedSegmentIndex;
    [self updateUI];
}

- (IBAction)changeGameType:(UISegmentedControl *)sender {
    NSString *cardsToMatch = (self.gameTypeControlButton.selectedSegmentIndex) ? @"three" : @"two";
    
    UIAlertView *feedback = [[UIAlertView alloc] initWithTitle:@"Gametype Changed"
                                                       message:[[NSString alloc] initWithFormat:@"You now have to match %@ cards", cardsToMatch]
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil];
    [feedback show];
    
    [self reDeal];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    long chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
    }
    
- (void)updateUI{
    for(UIButton *cardButton in self.cardButtons){
        long cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card =[self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;//a card.isMatched,we disable cardbutton
        self.scoreLabel.text =[NSString stringWithFormat:@"Score: %ld", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents: @"";
    
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen? @"cardfront": @"cardback"];
}
@end
