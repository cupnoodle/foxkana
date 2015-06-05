//
//  KanaCollectionViewCell.h
//  foxkana
//
//  Created by Soul on 6/6/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KanaCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *kanaLabel;
@property (weak, nonatomic) IBOutlet UILabel *kanaReading;

@end
