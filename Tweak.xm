//import AVFoundation and AudioServices for the Audio Player
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioServices.h>

        @interface SBUIController : NSObject {

        }
            //declare needed variables
			-(BOOL)isOnAC;
        @end


        //Audio Player variable
        AVAudioPlayer *player;

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
    } else {
		%orig;
	}
    if (self.isOnAC == false) {
        [player stop];
    }
}

%end