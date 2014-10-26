//
//  mainTabBarController.m
//  VisualMusic
//
//  Created by Fhict on 26/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "mainTabBarController.h"

@interface mainTabBarController ()

@end

@implementation mainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setPreference:@"redValue" :[NSNumber numberWithFloat:0 / 255]];
    [self setPreference:@"blueValue" :[NSNumber numberWithFloat:0 / 255]];
    [self setPreference:@"greenValue" :[NSNumber numberWithFloat:0 / 255]];
    [self setPreference:@"brushValue" :[NSNumber numberWithFloat:10]];
    [self setPreference:@"opacityValue" :[NSNumber numberWithFloat:1]];
    
    NSLog(@"went through initial)");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setPreference :(NSString*)key :(NSObject*) value
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:value forKey:key];
    [preferences synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
