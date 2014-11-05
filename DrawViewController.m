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

DrawnItem *rotationBuffer;
- (IBAction)chooseImage:(id)sender {
    //Imagepicker openen om een afbeelding te kiezen
    self.imagePicker = [[UIImagePickerController alloc ]init];
    self.imagePicker.delegate = self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePicker animated:YES completion:nil];
    
}

//Als er een afbeelding gekozen is
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Afbeelding weergeven
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.chosenImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Als afbeelding kiezen is geannuleerd
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveImage:(id)sender {
    UIGraphicsBeginImageContextWithOptions(_mainDrawnItem.bounds.size, NO,0.0);
    [_mainDrawnItem.image drawInRect:CGRectMake(0, 0, _mainDrawnItem.frame.size.width, _mainDrawnItem.frame.size.height)];
    UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
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

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    rotationBuffer = self.mainDrawnItem;
    UIInterfaceOrientation to = toInterfaceOrientation;
    UIInterfaceOrientation from = [[UIApplication sharedApplication] statusBarOrientation];
    CGFloat angle = 0.0;
    if(UIInterfaceOrientationIsLandscape(to))
    {
        if(UIInterfaceOrientationIsLandscape(from))
        {
            angle = -M_PI;
        }
        else if (UIInterfaceOrientationIsPortrait(from))
        {
            if((from == UIInterfaceOrientationPortrait && to == UIInterfaceOrientationLandscapeLeft)
               || (from == UIInterfaceOrientationPortraitUpsideDown && to == UIInterfaceOrientationLandscapeRight))
            {
                angle = M_PI_2;
            }
            else if((from == UIInterfaceOrientationPortrait && to == UIInterfaceOrientationLandscapeRight) || (from == UIInterfaceOrientationPortraitUpsideDown && to == UIInterfaceOrientationLandscapeLeft))
            {
                angle = -M_PI_2;
            }
        }
    }
    if(UIInterfaceOrientationIsPortrait(to))
    {
        if(UIInterfaceOrientationIsLandscape(from))
        {
            if((to == UIInterfaceOrientationPortrait && from == UIInterfaceOrientationLandscapeRight)
               || (to == UIInterfaceOrientationPortraitUpsideDown && from == UIInterfaceOrientationLandscapeLeft))
            {
                angle = M_PI_2;
            }
            else if((to == UIInterfaceOrientationPortrait && from == UIInterfaceOrientationLandscapeLeft) || (to == UIInterfaceOrientationPortraitUpsideDown && from == UIInterfaceOrientationLandscapeRight))
            {
                angle = -M_PI_2;
            }
        }
        else if (UIInterfaceOrientationIsPortrait(from))
        {
            angle = M_PI;
        }
    }
    
    rotationBuffer.transform = CGAffineTransformMakeRotation(angle);
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.mainDrawnItem = rotationBuffer;
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)viewWillAppear:(BOOL)animated
{

    [self setBrushColors];
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
    NSLog(@"brushvalue drawview: %f", self.brushValue);
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

- (IBAction)erase:(UISwitch *)sender
{
    [self setBrushColors];
}

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


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    self.mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.view];
}

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
