//
//  Kana.h
//  foxkana
//
//  Created by Soul on 6/3/15.
//  Copyright (c) 2015 sweatshop. All rights reserved.
//

#import <Realm/Realm.h>

@interface Kana : RLMObject
@property int key;
@property NSString *hiragana;
@property NSString *katakana;
@property NSString *reading;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Kana>
RLM_ARRAY_TYPE(Kana)
