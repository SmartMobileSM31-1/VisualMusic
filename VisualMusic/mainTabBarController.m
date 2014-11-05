//
//  mainTabBarController.m
//  VisualMusic
//
//  Created by Fhict on 26/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "mainTabBarController.h"
#import "AFHTTPRequestOperationManager.h"
#import "PreferenceHandler.h"

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
    [self loadJsonData];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// LOAD
-(void) loadJsonData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/x-javascript"];
    
    [manager GET:@"http://athena.fhict.nl/users/i293443/colors.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         //NSLog(@"JSON: %@", responseObject);
         [self parseJSONData:responseObject];
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error, %@", error);
     }];
}

// PARSE
-(void) parseJSONData:(id)JSON
{
    for(NSDictionary* dict in JSON)
    {
        NSNumber *redV = ((NSNumber*)[dict objectForKey:@"redValue"]);
        NSNumber *blueV = ((NSNumber*)[dict objectForKey:@"blueValue"]);
        NSNumber *greenV = ((NSNumber*)[dict objectForKey:@"greenValue"]);
        NSNumber *brushV = ((NSNumber*)[dict objectForKey:@"brushValue"]);
        NSNumber *opacityV = ((NSNumber*)[dict objectForKey:@"opacityValue"]);
        
        [PreferenceHandler setPreference:@"redValue" : redV];
        [PreferenceHandler setPreference:@"blueValue" : blueV];
        [PreferenceHandler setPreference:@"greenValue" : greenV];
        [PreferenceHandler setPreference:@"brushValue" : brushV];
        [PreferenceHandler setPreference:@"opacityValue" : opacityV];
    }
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
