//
//  learnViewController.h
//  foxkana
//
//  Created by Soul on 6/5/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface learnViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *hiraganaCollectionView;

@property (nonatomic, strong) NSMutableArray *kanaArray;
@end
