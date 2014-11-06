//
//  PlayViewController.h
//  VisualMusic
//
//  Created by Fhict on 05/11/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface PlayViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    AVAudioPlayer *playSound0;
    AVAudioPlayer *playSound1;
    AVAudioPlayer *playSound2;
    AVAudioPlayer *playSound3;
    AVAudioPlayer *playSound4;
    AVAudioPlayer *playSound5;
    AVAudioPlayer *playSound6;
    AVAudioPlayer *playSound7;
    IBOutlet UIButton *chooseImage;
    IBOutlet UIButton *playSound;
    IBOutlet UILabel *titelImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *chosenImage;
@property (strong, nonatomic) UIImagePickerController *imagePicker;

-(IBAction)showPlay;
-(IBAction)playSound:(id)sender;

@end