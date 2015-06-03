//
//  QuizViewController.m
//  foxkana
//
//  Created by Soul on 6/2/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "QuizViewController.h"
#import <Realm/Realm.h>
#import "Kana.h"
#import "ShuffleMutableArray.h"

@interface QuizViewController ()

@end

@implementation QuizViewController
NSMutableArray *questionIndexes;
NSNumber *chosenNumber;
NSMutableArray *wrongKanaArray;
NSMutableArray *mixedKanaArray;
Kana *questionKana;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    questionIndexes = [[NSMutableArray alloc] initWithCapacity:46];
    for(int i=1; i<=46; i++)
    {
        [questionIndexes addObject:[NSNumber numberWithInt:i]] ;
    }
    
    // Do any additional setup after loading the view.
    NSString *kanaRealmPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kana.realm"];
    NSError *error;
    //[RLMRealm setDefaultRealmPath: kanaRealmPath];
    RLMRealm *realm = [RLMRealm realmWithPath:kanaRealmPath readOnly:YES error:&error];
    NSLog(@"Realm path is at %@ \n", realm.path);
    
    //0 to 45(questionIndexes original count), arc4random_uniform(n) returns integer between 0 to n
    int randNum = arc4random_uniform((int)[questionIndexes count] - 1);
    
    chosenNumber = questionIndexes[randNum];
    [questionIndexes removeObjectAtIndex:randNum];
    
    NSPredicate *predForQuestion = [NSPredicate predicateWithFormat:@"key = %i ", [chosenNumber intValue]];
    RLMResults *questionKanaResults = [Kana objectsWithPredicate:predForQuestion];
    questionKana = [questionKanaResults objectAtIndex:0];
    
    NSPredicate *predForWrongAnswers = [NSPredicate predicateWithFormat:@"key != %i ", [chosenNumber intValue]];
    RLMResults *wrongAnswerResults = [Kana objectsWithPredicate:predForWrongAnswers];
    
    wrongKanaArray = [[NSMutableArray alloc] init];
    for(RLMObject *wrongAnswerObject in wrongAnswerResults)
    {
        [wrongKanaArray addObject:wrongAnswerObject];
    }
    
    //shuffle wrongKanaArray and only take 3 elements from it
    [wrongKanaArray shuffle];
    //nsmakerange(first index, how many element to remove from it)
    [wrongKanaArray removeObjectsInRange:NSMakeRange(3, wrongKanaArray.count - 3)];
    
    //Add correct kana and other three wrong into the mixed array then shuffle
    mixedKanaArray = [[NSMutableArray alloc] initWithArray:wrongKanaArray];
    [mixedKanaArray addObject:questionKana];
    [mixedKanaArray shuffle];
    
    [self.answer_1 setTitle:((Kana *)mixedKanaArray[0]).reading forState:UIControlStateNormal];
    [self.answer_2 setTitle:((Kana *)mixedKanaArray[1]).reading forState:UIControlStateNormal];
    [self.answer_3 setTitle:((Kana *)mixedKanaArray[2]).reading forState:UIControlStateNormal];
    [self.answer_4 setTitle:((Kana *)mixedKanaArray[3]).reading forState:UIControlStateNormal];
    
    self.questionLabel.text = questionKana.hiragana;
    
    //customize answer buttons
    self.answer_1.layer.cornerRadius = 5;
    self.answer_1.clipsToBounds = YES;
    self.answer_1.layer.masksToBounds = NO;
    self.answer_1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.answer_1.layer.shadowOpacity = 0.5;
    self.answer_1.layer.shadowRadius = 2;
    self.answer_1.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    self.answer_2.layer.cornerRadius = 5;
    self.answer_2.clipsToBounds = YES;
    self.answer_2.layer.masksToBounds = NO;
    self.answer_2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.answer_2.layer.shadowOpacity = 0.5;
    self.answer_2.layer.shadowRadius = 2;
    self.answer_2.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    self.answer_3.layer.cornerRadius = 5;
    self.answer_3.clipsToBounds = YES;
    self.answer_3.layer.masksToBounds = NO;
    self.answer_3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.answer_3.layer.shadowOpacity = 0.5;
    self.answer_3.layer.shadowRadius = 2;
    self.answer_3.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    self.answer_4.layer.cornerRadius = 5;
    self.answer_4.clipsToBounds = YES;
    self.answer_4.layer.masksToBounds = NO;
    self.answer_4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.answer_4.layer.shadowOpacity = 0.5;
    self.answer_4.layer.shadowRadius = 2;
    self.answer_4.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateNextQuestion {
    
}

- (void)prepareNextQuestion {
    
    //fade out all buttons and question label
    for (UIView *view in self.view.subviews)
    {
        if([view isMemberOfClass:[UIButton class]])
        {
            [UIView animateWithDuration:0.25 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{view.alpha = 0.0;} completion: nil];
        }
    }
    [UIView animateWithDuration:0.25 delay:2.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{self.questionLabel.alpha = 0.0;} completion: nil];
    
    
}

- (IBAction)answerButtonPressed:(id)sender {

    if(![[sender currentTitle] isEqualToString: questionKana.reading])
    {
        [sender setBackgroundColor: [UIColor colorWithRed:0.633 green:0.100 blue:0.114 alpha:1.000]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{((UIButton *)sender).alpha = 0.0;} completion: nil];
    }

    for (UIView *view in self.view.subviews)
    {
        if([view isMemberOfClass:[UIButton class]])
        {
            [(UIButton *)view setEnabled:NO];
            
            if([[(UIButton *)view currentTitle] isEqualToString: questionKana.reading])
            {
                //[(UIButton *)view setBackgroundColor: [UIColor colorWithRed:0.032 green:0.399 blue:0.199 alpha:1.000]];
                //[(UIButton *)view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [UIView animateWithDuration:0.75 delay:0.25 options:UIViewAnimationOptionCurveLinear animations:^{[(UIButton *)view setBackgroundColor: [UIColor colorWithRed:0.032 green:0.399 blue:0.199 alpha:1.000]]; [(UIButton *)view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];} completion: nil];
            }
            else
            {
                [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{((UIButton *)view).alpha = 0.0;} completion: nil];
            }
        }
    }
    
    [self prepareNextQuestion];

    
    
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
