//
//  SettingsViewController.h
//  VisualMusic
//
//  Created by Fhict on 26/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISlider *redSlider;
@property (strong, nonatomic) IBOutlet UISlider *greenSlider;
@property (strong, nonatomic) IBOutlet UISlider *blueSlider;
@property (strong, nonatomic) IBOutlet UISlider *opacitySlider;
@property (strong, nonatomic) IBOutlet UISlider *brushSlider;

@property (strong, nonatomic) IBOutlet UILabel *lblRedValue;
@property (strong, nonatomic) IBOutlet UILabel *lblGreenValue;
@property (strong, nonatomic) IBOutlet UILabel *lblBlueValue;
@property (strong, nonatomic) IBOutlet UILabel *lblOpacityValue;
@property (strong, nonatomic) IBOutlet UILabel *lblBrushValue;

- (IBAction)changeSlider:(UISlider *)sender;

@end
