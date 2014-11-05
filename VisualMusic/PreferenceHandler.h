//
//  PreferenceHandler.h
//  VisualMusic
//
//  Created by Fhict on 05/11/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreferenceHandler : NSObject

+ (float)getPreferenceValue :(NSString*)key;
+ (void)setPreference :(NSString*)key :(NSObject*) value;


@end
