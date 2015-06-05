//
//  QuizViewController.m
//  foxkana
//
//  Created by Soul on 6/2/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "QuizViewController.h"
#import "ResultViewController.h"
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
int score;
int numberOfQuestionAsked;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    score = 0;
    numberOfQuestionAsked = 0;
    
    questionIndexes = [[NSMutableArray alloc] initWithCapacity:71];
    for(int i=1; i<=71; i++)
    {
        [questionIndexes addObject:[NSNumber numberWithInt:i]] ;
    }
    
    
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
    
    //customize menu view
    self.menuView.layer.cornerRadius = 7;
    self.menuView.clipsToBounds = YES;
    self.menuView.layer.masksToBounds = NO;
    self.menuView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.menuView.layer.shadowOpacity = 0.5;
    self.menuView.layer.shadowRadius = 7;
    self.menuView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);

    
    //customize horizontal line inside menu view
    CAGradientLayer *gradient = [CAGradientLayer layer];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.5];
    NSNumber *stopThree     = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, nil];
    /*
    [self.horizontalLine_menuView setTranslatesAutoresizingMaskIntoConstraints:YES];
    gradient.frame = self.horizontalLine_menuView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, [UIColor colorWithWhite:0.762 alpha:1.000].CGColor, [UIColor whiteColor].CGColor, nil];
    gradient.locations = locations;
    //make the gradient horizontal, iOS by default is vertical
    gradient.startPoint = CGPointMake(0,0);
    gradient.endPoint = CGPointMake(1.0, 0);

    [self.horizontalLine_menuView.layer insertSublayer:gradient atIndex:0];
    */
    
    //customize vertical line
    gradient = [CAGradientLayer layer];
    stopOne = [NSNumber numberWithFloat:0.2];
    stopTwo = [NSNumber numberWithFloat:1.0];
    locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    gradient.frame = self.verticalLine_menuView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[UIColor colorWithWhite:0.762 alpha:1.000].CGColor, [UIColor whiteColor].CGColor, nil];
    gradient.locations = locations;
    [self.verticalLine_menuView.layer insertSublayer:gradient atIndex:0];
    
    //customize black view
    self.blackView.hidden = YES;
    self.blackView.alpha = 0.0;
    
    //set score to zero
    score = 0;
    self.scorelabel.text = [NSString stringWithFormat:@"%i", score];
    [self generateNextQuestion];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"Kana available count %i", (int)[questionIndexes count]);
}

- (void)viewDidLayoutSubviews{
    //move menu view to bottom
    self.menuView.frame = CGRectMake(self.menuView.frame.origin.x, self.view.frame
                                     .size.height + 10, self.menuView.frame.size.width, self.menuView.frame.size.height);
    
    NSLog(@"height is around %f", self.view.frame.size.height);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateNextQuestion {
    if(numberOfQuestionAsked >= 2)
    {
        [self performSegueWithIdentifier:@"showResultSegue" sender:self];
    }
    
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
    numberOfQuestionAsked += 1;
    
}

- (void)prepareNextQuestion {
    
    //fade in all buttons and question label
    for (UIView *view in self.view.subviews)
    {
        if([view isMemberOfClass:[UIButton class]] && ![view isMemberOfClass:[UtilityButton class]])
        {
            [(UIButton *)view setEnabled:YES];
            [(UIButton *)view setBackgroundColor:[UIColor whiteColor]];
            [(UIButton *)view setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{view.alpha = 1.0;} completion: nil];
            
        }
    }
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{self.questionLabel.alpha = 1.0; self.backButton.alpha = 1.0;} completion: nil];
    
    self.backButton.enabled = YES;
    
    
}

- (IBAction)answerButtonPressed:(id)sender {
    self.backButton.enabled = NO;
    //if wrong or correct
    if(![[sender currentTitle] isEqualToString: questionKana.reading])
    {
        [sender setBackgroundColor: [UIColor colorWithRed:0.633 green:0.100 blue:0.114 alpha:1.000]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{((UIButton *)sender).alpha = 0.0;} completion: nil];
    }
    else
    {
        [sender setBackgroundColor: [UIColor colorWithRed:0.032 green:0.399 blue:0.199 alpha:1.000]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        score += 1;
        self.scorelabel.text = [NSString stringWithFormat:@"%i", score];
    }
    
    for (UIView *view in self.view.subviews)
    {
        if([view isMemberOfClass:[UIButton class]] && ![view isMemberOfClass:[UtilityButton class]])
        {
            [(UIButton *)view setEnabled:NO];
            
            if([[(UIButton *)view currentTitle] isEqualToString: questionKana.reading])
            {
                
                
                [UIView animateWithDuration:0.75 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{
                    [(UIButton *)view setBackgroundColor: [UIColor colorWithRed:0.032 green:0.399 blue:0.199 alpha:1.000]];
                    [UIView transitionWithView:view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        [(UIButton *)view setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    } completion:nil];
                } completion: ^(BOOL finished){
                    [UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionCurveLinear animations:^{((UIButton *)view).alpha = 0.0;} completion:^(BOOL finished){[self generateNextQuestion];}];
                    [UIView animateWithDuration:0.5 delay:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{self.questionLabel.alpha = 0.0;} completion : ^(BOOL finished){[self prepareNextQuestion];}];
                }];
            }
            else
            {
                [UIView animateWithDuration:0.5 delay:0.5 options:UIViewAnimationOptionCurveLinear animations:^{((UIButton *)view).alpha = 0.0; self.backButton.alpha = 0.0;} completion: nil];
            }
        }
    }
    
    
}

- (IBAction)backButtonPressed:(id)sender {
    //disable all answer button
    
    [self.answer_1 setEnabled: NO];
    [self.answer_2 setEnabled: NO];
    [self.answer_3 setEnabled: NO];
    [self.answer_4 setEnabled: NO];
    
    
    self.blackView.hidden = NO;
    //move menu view to center and show black background
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.menuView.frame = CGRectMake(self.menuView.frame.origin.x, (self.view.frame.size.height - self.menuView.frame.size.height)/2.0, self.menuView.frame.size.width, self.menuView.frame.size.height);
        
        self.blackView.alpha = 0.85;
        
    } completion:^(BOOL finished){
        }];

}

- (IBAction)noButtonPressed:(id)sender {
    //enable all answer button
    [self.answer_1 setEnabled: YES];
    [self.answer_2 setEnabled: YES];
    [self.answer_3 setEnabled: YES];
    [self.answer_4 setEnabled: YES];
    
    //move menu view to bottom and hide black background
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.menuView.frame = CGRectMake(self.menuView.frame.origin.x, self.view.frame.size.height + 10 , self.menuView.frame.size.width, self.menuView.frame.size.height);
        self.blackView.alpha = 0.0;
        
    } completion:^(BOOL finished){
        self.blackView.hidden = YES;
    }];
    
}

- (IBAction)yesButtonPressed:(id)sender {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showResultSegue"]){
        ResultViewController *rcontroller = (ResultViewController *)segue.destinationViewController;
        rcontroller.score = score;
    }
}

- (IBAction)unwindToQuizView:(UIStoryboardSegue *)unwindSegue
{
    //reset score and questions
    score = 0;
    numberOfQuestionAsked = 0;
    
    questionIndexes = [[NSMutableArray alloc] initWithCapacity:46];
    for(int i=1; i<=46; i++)
    {
        [questionIndexes addObject:[NSNumber numberWithInt:i]] ;
    }
    
    self.scorelabel.text = [NSString stringWithFormat:@"%i", score];
    [self generateNextQuestion];
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
