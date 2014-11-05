//
//  SettingsViewController.m
//  VisualMusic
//
//  Created by Fhict on 26/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "SettingsViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
//    [self setPreference:@"redValue" :[NSNumber numberWithFloat:0 / 255]];
//    [self setPreference:@"blueValue" :[NSNumber numberWithFloat:0 / 255]];
//    [self setPreference:@"greenValue" :[NSNumber numberWithFloat:0 / 255]];
//    [self setPreference:@"brushValue" :[NSNumber numberWithFloat:10]];
//    [self setPreference:@"opacityValue" :[NSNumber numberWithFloat:1]];
    [self loadJsonData];
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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
        
        
        self.redSlider.value = redV.floatValue;
        self.blueSlider.value = blueV.floatValue;
        self.greenSlider.value = greenV.floatValue;
        self.brushSlider.value = brushV.floatValue;
        self.opacitySlider.value = opacityV.floatValue;
        [self setLabelValues];
        
        NSLog(@"brush value from json: %f", ((NSNumber*)[dict objectForKey:@"brushValue"]).floatValue);
        
        [self setPreference:@"redValue" : redV];
        [self setPreference:@"blueValue" : blueV];
        [self setPreference:@"greenValue" : greenV];
        [self setPreference:@"brushValue" : brushV];
        [self setPreference:@"opacityValue" : opacityV];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
}

- (void)setLabelValues
{
    self.lblRedValue.text = [NSString stringWithFormat:@"%d", (int)self.redSlider.value];
    self.lblGreenValue.text = [NSString stringWithFormat:@"%d", (int)self.greenSlider.value];
    self.lblBlueValue.text = [NSString stringWithFormat:@"%d", (int)self.blueSlider.value];
    self.lblOpacityValue.text = [NSString stringWithFormat:@"%d", (int)self.opacitySlider.value];
    self.lblBrushValue.text = [NSString stringWithFormat:@"%d", (int)self.brushSlider.value];
}

- (IBAction)changeRed:(UISlider *)sender
{
    [self setPreference:@"redValue" :[NSNumber numberWithFloat:sender.value / 255]];
}
- (IBAction)changeGreen:(UISlider *)sender
{
    [self setPreference:@"greenValue" :[NSNumber numberWithFloat:sender.value / 255]];
}
- (IBAction)changeBlue:(UISlider *)sender
{
    [self setPreference:@"blueValue" :[NSNumber numberWithFloat:sender.value / 255]];
}
- (IBAction)changeOpacity:(UISlider *)sender
{
    [self setPreference:@"opacityValue" :[NSNumber numberWithFloat:sender.value]];
}
- (IBAction)changeBrush:(UISlider *)sender
{
    [self setPreference:@"brushValue" :[NSNumber numberWithFloat:sender.value]];
}

- (void)setPreference :(NSString*)key :(NSObject*) value
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setObject:value forKey:key];
    [preferences synchronize];
    [self setLabelValues];
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
