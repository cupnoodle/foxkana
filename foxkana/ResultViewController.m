//
//  ResultViewController.m
//  foxkana
//
//  Created by Soul on 6/4/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "ResultViewController.h"
#import "QuizViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scoreLabel.text = [NSString stringWithFormat:@"%i", self.score];
    
    //customize play again button
    self.playAgainButton.layer.cornerRadius = 5;
    self.playAgainButton.clipsToBounds = YES;
    self.playAgainButton.layer.masksToBounds = NO;
    self.playAgainButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.playAgainButton.layer.shadowOpacity = 0.5;
    self.playAgainButton.layer.shadowRadius = 2;
    self.playAgainButton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    //customize back to main menu button
    self.backToMainButton.layer.cornerRadius = 5;
    self.backToMainButton.clipsToBounds = YES;
    self.backToMainButton.layer.masksToBounds = NO;
    self.backToMainButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backToMainButton.layer.shadowOpacity = 0.5;
    self.backToMainButton.layer.shadowRadius = 2;
    self.backToMainButton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAgainPressed:(id)sender {
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
