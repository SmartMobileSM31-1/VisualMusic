//
//  PlayViewController.m
//  VisualMusic
//
//  Created by Fhict on 05/11/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "PlayViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface PlayViewController ()
@property NSMutableArray *soundsArray;
@end

@implementation PlayViewController

//Choose image
- (IBAction)chooseImage:(id)sender {
    //Imagepicker openen om een afbeelding te kiezen
    self.imagePicker = [[UIImagePickerController alloc ]init];
    self.imagePicker.delegate = self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

//Image is chosen
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Show image
    self.chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.imageView setImage:self.chosenImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //Show name of image
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@",[imageRep filename]);
        [titelImage setText:[imageRep filename]];
    };
    
    ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc]init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
}

//Choose image cancled
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Play sound
- (IBAction)playSound:(id)sender {
    [_soundsArray removeAllObjects];
    
    //Make points to get sound
    //display 250 x 350
    //starts  35 x 50
    
    CGPoint P1 = CGPointMake(105, 185);
    CGPoint P2 = CGPointMake(160, 185);
    CGPoint P3 = CGPointMake(205, 185);
    CGPoint P4 = CGPointMake(105, 240);
    CGPoint P5 = CGPointMake(160, 240);
    CGPoint P6 = CGPointMake(205, 240);
    CGPoint P7 = CGPointMake(105, 295);
    CGPoint P8 = CGPointMake(160, 295);
    CGPoint P9 = CGPointMake(295, 295);
    /*
    CGPoint P1 = CGPointMake(70, 135);
    CGPoint P2 = CGPointMake(125, 135);
    CGPoint P3 = CGPointMake(170, 135);
    CGPoint P4 = CGPointMake(70, 190);
    CGPoint P5 = CGPointMake(125, 190);
    CGPoint P6 = CGPointMake(170, 190);
    CGPoint P7 = CGPointMake(70, 245);
    CGPoint P8 = CGPointMake(125, 245);
    CGPoint P9 = CGPointMake(170, 245);
    */
    //Get the sounds
    [self soundAtPosition:(P1)];
    [self soundAtPosition:(P2)];
    [self soundAtPosition:(P3)];
    [self soundAtPosition:(P4)];
    [self soundAtPosition:(P5)];
    [self soundAtPosition:(P6)];
    [self soundAtPosition:(P7)];
    [self soundAtPosition:(P8)];
    [self soundAtPosition:(P9)];
    
    //Play the sounds
    for(AVAudioPlayer *a in _soundsArray){
        [a play];
        sleep(1);
        [a stop];
    }
}

//Get sound from image
- (void)soundAtPosition:(CGPoint)position {
    //Get RGB colors
    CGRect sourceRect = CGRectMake(position.x, position.y, 1.f, 1.f);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.chosenImage.CGImage, sourceRect);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *buffer = malloc(4);
    CGBitmapInfo bitmapInfo = kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big;
    CGContextRef context = CGBitmapContextCreate(buffer, 1, 1, 8, 4, colorSpace, bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0.f, 0.f, 1.f, 1.f), imageRef);
    CGImageRelease(imageRef);
    CGContextRelease(context);
    
    CGFloat r = buffer[0] / 255.f;
    CGFloat g = buffer[1] / 255.f;
    CGFloat b = buffer[2] / 255.f;
    CGFloat a = buffer[3] / 255.f;
    
    free(buffer);
    NSLog(@"%f,%f,%f,%f",r,g,b,a);
    
    //Set color to sound
    if(r<=0.33)
    {
        if(g<=0.33)
        {
            if (b<=0.33)
            {
                [_soundsArray addObject:playSound0];
            }
            else
            {
                [_soundsArray addObject:playSound1];
            }
        }
        else
        {
            if (b<=0.33)
            {
                [_soundsArray addObject:playSound2];
            }
            else
            {
                [_soundsArray addObject:playSound3];
            }
        }
    }
    else
    {
        if(g<=0.33)
        {
            if (b<=0.33)
            {
                [_soundsArray addObject:playSound4];
            }
            else
            {
                [_soundsArray addObject:playSound5];
            }
        }
        else
        {
            if (b<=0.33)
            {
                [_soundsArray addObject:playSound6];
            }
            else
            {
                [_soundsArray addObject:playSound7];
            }
        }
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


//Show play button(only first time)
-(IBAction)showPlay{
    if([playSound.currentTitle isEqual:@"Play"])
    {
        playSound.hidden=NO;
    }
    else
    {
        playSound.hidden=YES;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _soundsArray = [NSMutableArray new];
    
    //Map the sound images
    NSString *soundURL0 = [[NSBundle mainBundle] pathForResource:@"Beep0" ofType:@"mp3"];
    playSound0 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL0] error:NULL];
    NSString *soundURL1 = [[NSBundle mainBundle] pathForResource:@"Beep1" ofType:@"mp3"];
    playSound1 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL1] error:NULL];
    NSString *soundURL2 = [[NSBundle mainBundle] pathForResource:@"Beep2" ofType:@"mp3"];
    playSound2 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL2] error:NULL];
    NSString *soundURL3 = [[NSBundle mainBundle] pathForResource:@"Beep3" ofType:@"mp3"];
    playSound3 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL3] error:NULL];
    NSString *soundURL4 = [[NSBundle mainBundle] pathForResource:@"Beep4" ofType:@"mp3"];
    playSound4 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL4] error:NULL];
    NSString *soundURL5 = [[NSBundle mainBundle] pathForResource:@"Beep5" ofType:@"mp3"];
    playSound5 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL5] error:NULL];
    NSString *soundURL6 = [[NSBundle mainBundle] pathForResource:@"Beep6" ofType:@"mp3"];
    playSound6 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL6] error:NULL];
    NSString *soundURL7 = [[NSBundle mainBundle] pathForResource:@"Sound0" ofType:@"wav"];
    playSound7 = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundURL7] error:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
