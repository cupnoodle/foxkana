//
//  QuizViewController.h
//  foxkana
//
//  Created by Soul on 6/2/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilityButton.h"

@interface QuizViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *answer_1;
@property (weak, nonatomic) IBOutlet UIButton *answer_2;
@property (weak, nonatomic) IBOutlet UIButton *answer_3;
@property (weak, nonatomic) IBOutlet UIButton *answer_4;
@property (weak, nonatomic) IBOutlet UILabel *scorelabel;

@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine_menuView;
@property (weak, nonatomic) IBOutlet UIView *verticalLine_menuView;

@property (weak, nonatomic) IBOutlet UtilityButton *backButton;


@end
