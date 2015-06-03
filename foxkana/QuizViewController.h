//
//  QuizViewController.h
//  foxkana
//
//  Created by Soul on 6/2/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UIButton *answer_1;
@property (weak, nonatomic) IBOutlet UIButton *answer_2;
@property (weak, nonatomic) IBOutlet UIButton *answer_3;
@property (weak, nonatomic) IBOutlet UIButton *answer_4;
@property (weak, nonatomic) IBOutlet UILabel *scorelabel;
@end
