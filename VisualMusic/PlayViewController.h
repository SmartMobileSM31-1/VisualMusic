//
//  PlayViewController.h
//  VisualMusic
//
//  Created by Fhict on 05/11/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PlayViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIButton *chooseImage;
    IBOutlet UIButton *playSound;
    IBOutlet UILabel *titelImage;
    SystemSoundID playSoundID0;
    SystemSoundID playSoundID1;
    SystemSoundID playSoundID2;
    SystemSoundID playSoundID3;
    SystemSoundID playSoundID4;
    SystemSoundID playSoundID5;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *chosenImage;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

-(IBAction)showPlay;
-(IBAction)playSound:(id)sender;

@end