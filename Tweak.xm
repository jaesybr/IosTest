#import "Macros.h"

/***********************************************************
  INSIDE THE FUNCTION BELOW YOU'LL HAVE TO ADD YOUR SWITCHES!
***********************************************************/
void setup() {

  //See sample.xm for a example Tweak.xm

  //patching offsets directly, without switch
  patchOffset(0x1002DB3C8, "0xC0035FD6");
  patchOffset(0x10020D2D4, "0x00008052C0035FD6");

  // You can write as many bytes as you want to an offset
  patchOffset(0x10020D3A8, "0x00F0271E0008201EC0035FD6");
  // or  
  patchOffset(0x10020D3A8, "00F0271E0008201EC0035FD6");
  // spaces are fine too
  patchOffset(0x10020D3A8, "00 F0 27 1E 00 08 20 1E C0 03 5F D6");





/**********************************************************************************************************
     You can customize the menu here
     For colors, you can use hex color codes or UIColor itself
      - For the hex color #BD0000 you'd use: UIColorFromHex(0xBD0000)
      - For UIColor you can visit this site: https://www.uicolor.xyz/#/rgb-to-ui
        NOTE: remove the ";" when you copy your UIColor from there!
     
     Site to find your perfect font for the menu: http://iosfonts.com/  --> view on mac or ios device
     See comment next to maxVisibleSwitches!!!!

     menuIcon & menuButton is base64 data, upload a image to: https://www.browserling.com/tools/image-to-base64 \
     then replace that string with mine.
************************************************************************************************************/
void setupMenu() {

  // If a game uses a framework as base executable, you can enter the name here.
  // For example: UnityFramework, in that case you have to replace NULL with "UnityFramework" (note the quotes)
  [menu setFrameworkName:NULL];

  menu = [[Menu alloc]  
            initWithTitle:@"rez_tap"
            titleColor:[UIColor whiteColor]
            titleFont:@"Copperplate-Bold"
            credits:@"Rezware"
            headerColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7]
            switchOffColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5]
            switchOnColor:UIColorFromHex(0x000000)
            switchTitleFont:@"Copperplate-Bold"
            switchTitleColor:[UIColor whiteColor]
            infoButtonColor:[UIColor clearColor]
            maxVisibleSwitches:4
            menuWidth:350
            menuIcon:@""
            menuButton:@""];


    /********************************************************************
        Once menu has been initialized, it will run the setup functions. 
        All of your switches should be entered in the setup() function!
    *********************************************************************/
    setup();
}

// If the menu button doesn't show up; Change the timer to a bigger amount.
static void didFinishLaunching(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
  timer(5) {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];

    // Website link, remove it if you don't need it.
    [alert addButton: @"мой диискорд" actionBlock: ^(void) {
      [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"https://discord.gg/SeYdm6Tg7z"]];
      timer(2) {
        setupMenu();
      });        
    }];

    [alert addButton: @"продолжить" actionBlock: ^(void) {
      timer(2) {
        setupMenu();
      });
    }];    

    alert.shouldDismissOnTapOutside = NO;
    alert.customViewColor = [UIColor purpleColor];  
    alert.showAnimationType = SCLAlertViewShowAnimationSlideInFromCenter;   
    
    [alert showSuccess: nil
            subTitle:@"Моя шутка: Один еврей жалел,  что он не бывал в лагере когда был ребенком, третий рейх все исправил!
Все в синагоге: ну я просто похлопаю" 
              closeButtonTitle:nil
                duration:99999999.0f];
  });
}


%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, &didFinishLaunching, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}