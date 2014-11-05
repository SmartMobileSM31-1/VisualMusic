//
//  PreferenceHandler.m
//  VisualMusic
//
//  Created by Fhict on 05/11/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "PreferenceHandler.h"

@implementation PreferenceHandler


// returns a float value from user preferences for given key value
+ (float)getPreferenceValue :(NSString*)key
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    float output = ((NSNumber*)[preferences objectForKey:key]).floatValue;
    return output;
}

+ (void)setPreference :(NSString*)key :(NSObject*) value
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:value forKey:key];
    [preferences synchronize];
}

@end
