//
//  SettingsViewController.m
//  VisualMusic
//
//  Created by Fhict on 26/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "SettingsViewController.h"
#import "PreferenceHandler.h"


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
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}



- (void)viewWillAppear:(BOOL)animated
{
    [self loadPreferences];
    [super viewWillAppear:animated];
}

// loads color / brush / opacity values from User Preferences, through the PreferenceHandler
- (void)loadPreferences
{
    self.redSlider.value = [PreferenceHandler getPreferenceValue:@"redValue"];
    self.blueSlider.value = [PreferenceHandler getPreferenceValue:@"blueValue"];
    self.greenSlider.value = [PreferenceHandler getPreferenceValue:@"greenValue"];
    self.brushSlider.value = [PreferenceHandler getPreferenceValue:@"brushValue"];
    self.opacitySlider.value = [PreferenceHandler getPreferenceValue:@"opacityValue"];
    [self setLabelValues];
}

// updates label values to match their sliders
- (void)setLabelValues
{
    self.lblRedValue.text = [NSString stringWithFormat:@"%d", (int)self.redSlider.value];
    self.lblGreenValue.text = [NSString stringWithFormat:@"%d", (int)self.greenSlider.value];
    self.lblBlueValue.text = [NSString stringWithFormat:@"%d", (int)self.blueSlider.value];
    self.lblOpacityValue.text = [NSString stringWithFormat:@"%d", (int)self.opacitySlider.value];
    self.lblBrushValue.text = [NSString stringWithFormat:@"%d", (int)self.brushSlider.value];
}

// Called by the various sliders, identified by tag number
// Updates preference to new slider value
// Updates labels
- (IBAction)changeSlider:(UISlider *)sender
{
    if(sender.tag == 1)
    {
        [PreferenceHandler setPreference:@"redValue" :[NSNumber numberWithFloat:sender.value / 255]];
    }
    else if(sender.tag == 2)
    {
        [PreferenceHandler setPreference:@"greenValue" :[NSNumber numberWithFloat:sender.value / 255]];
    }
    else if(sender.tag == 3)
    {
        [PreferenceHandler setPreference:@"blueValue" :[NSNumber numberWithFloat:sender.value / 255]];
    }
    else if(sender.tag == 4)
    {
        [PreferenceHandler setPreference:@"opacityValue" :[NSNumber numberWithFloat:sender.value]];
    }
    else if (sender.tag == 5)
    {
        [PreferenceHandler setPreference:@"brushValue" :[NSNumber numberWithFloat:sender.value]];
    }
    
    [self setLabelValues];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
