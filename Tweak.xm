//import AVFoundation and AudioServices for the Audio Player
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

        @interface SBUIController : NSObject {

        }
            //declare needed variables
			-(BOOL)isOnAC;
        @end


        //other needed variables
        AVAudioPlayer *player;
        UIImageView *Image;
    	UIWindow *Window;

        //Sound paths
        NSString *soundPath = [[NSBundle bundleWithPath:@"/Library/Application Support/ChargePain/"] pathForResource:@"goat" ofType:@"caf"];
    	NSURL *soundURL = [[NSURL alloc] initFileURLWithPath:soundPath];

//hook sbuicontroller and declare new functionalities of the "playConnectedToPowerSoundIfNecessary" function
%hook SBUIController
-(void)playConnectedToPowerSoundIfNecessary {

    //if device is fully charged (100%) play sound
    if (self.isOnAC == true) {
            nil;
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:nil];
		//"infinite" loop
        player.numberOfLoops = 999999;
        player.volume = 1;
                
        [player play];

        Window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
      	Image.center = Window.center;
      	Window.backgroundColor = [UIColor clearColor];
      	Image = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:@"/Library/Application Support/ChargePain/goat.png"]];
      	Window.hidden = NO;
      	[Window addSubview: Image];
    } else {
		%orig;
	}
    if (self.isOnAC == false) {
        [player stop];
        Window.alpha = 0;
        Image.alpha = 0;
        [Window removeFromSuperview];
        [Image removeFromSuperview];
    }
}

%end