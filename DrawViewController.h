//
//  DrawViewController.h
//  VisualMusic
//
//  Created by Fhict on 16/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawnItem.h"

@interface DrawViewController : UIViewController

@property (strong, nonatomic) IBOutlet DrawnItem *mainDrawnItem;
@property (strong, nonatomic) IBOutlet DrawnItem *tempDrawnItem;

- (IBAction)erase:(UIButton *)sender;

@property CGPoint lastPoint;
@property CGFloat redValue;
@property CGFloat greenValue;
@property CGFloat blueValue;
@property CGFloat brushValue;
@property CGFloat opacityValue;
@property BOOL mouseSwiped;


@end
