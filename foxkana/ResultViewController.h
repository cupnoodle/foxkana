//
//  ResultViewController.h
//  foxkana
//
//  Created by Soul on 6/4/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic) int score;

@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;
@property (weak, nonatomic) IBOutlet UIButton *backToMainButton;

@end
