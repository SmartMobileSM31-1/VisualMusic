//
//  SettingsViewController.m
//  VisualMusic
//
//  Created by Fhict on 26/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "SettingsViewController.h"

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
    [self setPreference:@"redValue" :[NSNumber numberWithFloat:0 / 255]];
    [self setPreference:@"blueValue" :[NSNumber numberWithFloat:0 / 255]];
    [self setPreference:@"greenValue" :[NSNumber numberWithFloat:0 / 255]];
    [self setPreference:@"brushValue" :[NSNumber numberWithFloat:10]];
    [self setPreference:@"opacityValue" :[NSNumber numberWithFloat:1]];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
