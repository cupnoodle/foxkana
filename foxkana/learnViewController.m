//
//  learnViewController.m
//  foxkana
//
//  Created by Soul on 6/5/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import "learnViewController.h"
#import <Realm/Realm.h>
#import <QuartzCore/QuartzCore.h>
#import "Kana.h"
#import "KanaCollectionViewCell.h"

@interface learnViewController ()

@end

@implementation learnViewController
Kana *blankKana;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.kanaArray =[[NSMutableArray alloc] init];
    //Open realm database
    NSString *kanaRealmPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kana.realm"];
    NSError *error;
    //[RLMRealm setDefaultRealmPath: kanaRealmPath];
    RLMRealm *realm = [RLMRealm realmWithPath:kanaRealmPath readOnly:YES error:&error];
    NSLog(@"Realm path is at %@ \n", realm.path);
    
    RLMResults *allKanaResults = [Kana allObjectsInRealm:realm];
    
    for(RLMObject *kanaObject in allKanaResults)
    {
        [self.kanaArray addObject:kanaObject];
    }
    
    blankKana = [[Kana alloc] init];
    blankKana.key = 99;
    blankKana.hiragana = @"";
    blankKana.katakana = @"";
    blankKana.reading = @"";
    
    NSMutableIndexSet *mutableIndexSet = [[NSMutableIndexSet alloc] init];
    [mutableIndexSet addIndex: 36];
    [mutableIndexSet addIndex:38];
    [mutableIndexSet addIndex:46];
    [mutableIndexSet addIndex:47];
    [mutableIndexSet addIndex:48];
    [mutableIndexSet addIndex:51];
    [mutableIndexSet addIndex:52];
    [mutableIndexSet addIndex:53];
    [mutableIndexSet addIndex:54];

    NSArray *blankKanaArray = [[NSArray alloc] initWithObjects: blankKana, blankKana, blankKana, blankKana, blankKana, blankKana, blankKana, blankKana, blankKana, nil];
    [self.kanaArray insertObjects: blankKanaArray atIndexes: mutableIndexSet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.kanaArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"kanaCell";
    if(indexPath.row %10 <5)
    {
        cellIdentifier = @"kanaEvenCell";
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    Kana *tmpKana = [self.kanaArray objectAtIndex:indexPath.row];
    ((KanaCollectionViewCell *)cell).kanaLabel.text = tmpKana.hiragana;
    ((KanaCollectionViewCell *)cell).kanaReading.text = tmpKana.reading;
    

    //[cell.layer setBorderColor:[UIColor grayColor].CGColor];
    //[cell.layer setBorderWidth:1.0f];
    
    NSLog(@"cell width is %i", (int)cell.frame.size.width);
    if((int)cell.frame.size.width >=80)
    {
        ((KanaCollectionViewCell *)cell).kanaLabel.font = [((KanaCollectionViewCell *)cell).kanaLabel.font fontWithSize:27.0];
    }
    
    if([cellIdentifier isEqualToString:@"kanaEvenCell"])
    {
        [cell setBackgroundColor:[UIColor colorWithRed:0.888 green:0.757 blue:0.380 alpha:1.000]];
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.hiraganaCollectionView layoutMarginsDidChange];
    [self.hiraganaCollectionView needsUpdateConstraints];
    return CGSizeMake((self.hiraganaCollectionView.frame.size.width /5.0), (self.hiraganaCollectionView.frame.size.width /5.0));
}

@end
