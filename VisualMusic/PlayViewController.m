//
//  PlayViewController.m
//  VisualMusic
//
//  Created by Fhict on 05/11/14.
//  Copyright (c) 2014 Fhict. All rights reserved.
//

#import "PlayViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface PlayViewController ()

@end

@implementation PlayViewController
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
    
    //Proberen de naam van het plaatje op te halen
    //Helaas zijn we hier niet uitgekomen, maar we hebben het geprobeerd
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@",[imageRep filename]);
        [self changeImageTitle:[imageRep filename]];
    };
    
    ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc]init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
}

//Als afbeelding kiezen is geannuleerd
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Naam van het plaatje weergeven
-(void)changeImageTitle:(NSString *)str{
    [titelImage setText: str];
}
- (IBAction)playSound:(id)sender {
    AudioServicesPlaySystemSound(playSoundID0);
    sleep(1);
    AudioServicesPlaySystemSound(playSoundID1);
    sleep(1);/*
    AudioServicesPlaySystemSound(playSoundID2);
    sleep(1);
    AudioServicesPlaySystemSound(playSoundID3);
    sleep(1);
    AudioServicesPlaySystemSound(playSoundID4);
    sleep(1);
    AudioServicesPlaySystemSound(playSoundID5);*/
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//Bepalen of de knop play worden weergegeven
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
    NSURL *soundURL0 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(@"Sound0") ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL0, &playSoundID0);
    NSURL *soundURL1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(@"Sound1") ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL1, &playSoundID1);
    NSURL *soundURL2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(@"Sound2") ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL2, &playSoundID2);
    NSURL *soundURL3 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(@"Sound3") ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL3, &playSoundID3);
    NSURL *soundURL4 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(@"Sound4") ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL4, &playSoundID4);
    NSURL *soundURL5 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:(@"Sound5") ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL5, &playSoundID5);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
