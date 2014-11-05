//
//  DrawViewController.h
//  VisualMusic
//
//  Created by Fhict on 16/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawnItem.h"

@interface DrawViewController : UIViewController< UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIButton *chooseImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *chosenImage;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) IBOutlet DrawnItem *mainDrawnItem;
@property (strong, nonatomic) IBOutlet DrawnItem *tempDrawnItem;
@property (strong, nonatomic) IBOutlet UISwitch *eraseSwitch;
@property (strong, nonatomic) IBOutlet UIButton *btnNew;

- (IBAction)erase:(UISwitch *)sender;
- (IBAction)clearScreen:(UIButton *)sender;

@property CGPoint lastPoint;
@property CGFloat redValue;
@property CGFloat greenValue;
@property CGFloat blueValue;
@property CGFloat brushValue;
@property CGFloat opacityValue;
@property BOOL mouseSwiped;


@end
