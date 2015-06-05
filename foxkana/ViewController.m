//
//  ViewController.m
//  foxkana
//
//  Created by Soul on 6/2/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //customize play quiz button
    self.startButton.layer.cornerRadius = 5;
    self.startButton.clipsToBounds = YES;
    self.startButton.layer.masksToBounds = NO;
    self.startButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.startButton.layer.shadowOpacity = 0.5;
    self.startButton.layer.shadowRadius = 2;
    self.startButton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    //customize learn button
    self.learnButton.layer.cornerRadius = 5;
    self.learnButton.clipsToBounds = YES;
    self.learnButton.layer.masksToBounds = NO;
    self.learnButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.learnButton.layer.shadowOpacity = 0.5;
    self.learnButton.layer.shadowRadius = 2;
    self.learnButton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToMainView:(UIStoryboardSegue *)unwindSegue
{
    
}

@end
