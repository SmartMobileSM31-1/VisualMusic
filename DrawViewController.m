//
//  DrawViewController.m
//  VisualMusic
//
//  Created by Fhict on 16/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "DrawViewController.h"
#import <UIKit/UIKit.h>

@interface DrawViewController ()

@end

@implementation DrawViewController


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
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    CGRect frame = self.tempDrawnItem.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size = screenSize;
    
    self.tempDrawnItem.bounds = screenBound;
    self.mainDrawnItem.bounds = screenBound;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getValues];
//    NSLog(@"went through viewWillAppear");
    [super viewWillAppear:animated];
}

-(float)getPreferenceValue :(NSString*)key
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    float output = ((NSNumber*)[preferences objectForKey:key]).floatValue;
    return output;
}

-(void)getValues
{
    self.redValue = [self getPreferenceValue:@"redValue"];
    self.greenValue = [self getPreferenceValue:@"greenValue"];
    self.blueValue = [self getPreferenceValue:@"blueValue"];
    self.brushValue = [self getPreferenceValue:@"brushValue"];
    self.opacityValue = [self getPreferenceValue:@"opacityValue"];
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

- (IBAction)erase:(UIButton *)sender
{
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawnItem.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushValue );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.redValue, self.greenValue, self.blueValue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawnItem.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawnItem setAlpha:self.opacityValue];
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(!self.mouseSwiped)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawnItem.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brushValue);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.redValue, self.greenValue, self.blueValue, self.opacityValue);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawnItem.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainDrawnItem.frame.size);
    [self.mainDrawnItem.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawnItem.image drawInRect:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) blendMode:kCGBlendModeNormal alpha:self.opacityValue];
    self.mainDrawnItem.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawnItem.image = nil;
    UIGraphicsEndImageContext();
}
@end
