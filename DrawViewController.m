//
//  DrawViewController.m
//  VisualMusic
//
//  Created by Fhict on 16/10/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "DrawViewController.h"
#import <UIKit/UIKit.h>
#import "PreferenceHandler.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

//DrawnItem *rotationBuffer;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// Whenever view is selected, updates brush colors
- (void)viewWillAppear:(BOOL)animated
{
    [self setBrushColors];
//    NSLog(@"went through viewWillAppear");
    [super viewWillAppear:animated];
}

// loads color / brush / opacity values from user preferences
-(void)getValues
{
    self.redValue = [PreferenceHandler getPreferenceValue:@"redValue"];
    self.greenValue = [PreferenceHandler getPreferenceValue:@"greenValue"];
    self.blueValue = [PreferenceHandler getPreferenceValue:@"blueValue"];
    self.brushValue = [PreferenceHandler getPreferenceValue:@"brushValue"];
    self.opacityValue = [PreferenceHandler getPreferenceValue:@"opacityValue"];
}



// New button - clears the entire screen, does not save
- (IBAction)clearScreen:(UIButton *)sender
{
    self.mainDrawnItem.image = nil;
}

// toggles the eraser function (white colors, brush / opacity unchanged)
- (IBAction)erase:(UISwitch *)sender
{
    [self setBrushColors];
}

// sets brush colors - white if eraser was toggled, loads from user settings otherwise
- (void)setBrushColors
{
    if(self.eraseSwitch.on)
    {
        self.redValue = 255;
        self.greenValue = 255;
        self.blueValue = 255;
    }
    else
    {
        [self getValues];
    }
}

// Load Image
- (IBAction)chooseImage:(id)sender
{
    //Imagepicker openen om een afbeelding te kiezen
    self.imagePicker = [[UIImagePickerController alloc ]init];
    self.imagePicker.delegate = self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

// If an Image was selected
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Afbeelding weergeven
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.mainDrawnItem setImage:self.chosenImage];
    //[self.imageView setImage:self.chosenImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// If selection was cancelled
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Saves image to gallery
- (IBAction)saveImage:(id)sender
{
    UIGraphicsBeginImageContextWithOptions(_mainDrawnItem.bounds.size, NO,0.0);
    [_mainDrawnItem.image drawInRect:CGRectMake(0, 0, _mainDrawnItem.frame.size.width, _mainDrawnItem.frame.size.height)];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}

// finished saving Image
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Image could not be saved.Please try again"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Image was successfully saved in photoalbum"  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Close", nil];
        [alert show];
    }
}

// User started drawing
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

// User dragged his finger over the drawing screen
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
    
    self.mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    //NSLog(@"current point: %f, %f", currentPoint.x, currentPoint.y);
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.tempDrawnItem.image drawInRect:self.view.frame];
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

// User is done drawing a line - line is saved from tempImage to mainImage
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(!self.mouseSwiped)
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawnItem.image drawInRect:self.view.frame];
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
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.mainDrawnItem.image drawInRect:self.view.frame blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawnItem.image drawInRect:self.view.frame blendMode:kCGBlendModeNormal alpha:self.opacityValue];
    self.mainDrawnItem.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawnItem.image = nil;
    UIGraphicsEndImageContext();
}


@end
