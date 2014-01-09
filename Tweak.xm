static BOOL CLisEnabled = YES; // Default value
static NSString* CLtext = @"Custom LockScreen";
static BOOL CLHideText = NO;
static BOOL CLHideTopGrabber = NO;
static BOOL CLHideBotGrabber = NO;
static BOOL CLHideCamGrabber = NO;
static BOOL CLHideLockDate = NO;
static BOOL CLShowStatusBarTime = NO;
static BOOL CLSmallStatusBar = NO;


%hook SBLockScreenView
-(void)setCustomSlideToUnlockText:(id)unlockText{
	if(CLtext && CLisEnabled){
        unlockText = CLtext;
    }
    if(CLHideText){
        unlockText = @" ";
    }
	%orig(unlockText);

}
-(void)setTopGrabberHidden:(BOOL)hidden forRequester:(id)requester{
    if(CLHideTopGrabber){
        hidden = YES;
    }
    %orig(hidden, requester);
}
-(void)setBottomGrabberHidden:(BOOL)hidden forRequester:(id)requester{
    if(CLHideBotGrabber){
        hidden = YES;
    }
    %orig(hidden, requester);
}
-(void)setCameraGrabberHidden:(BOOL)hidden forRequester:(id)requester{
    if(CLHideCamGrabber){
        hidden = YES;
    }
    %orig(hidden, requester);
}
%end

%hook SBLockScreenViewController

-(float)_effectiveOpacityForVisibleDateView{
    if(CLHideLockDate)
        return 0;
    return %orig;
}
-(float)_effectiveVisibleStatusBarAlpha{
    if(CLHideLockDate)
        return 10;
    return %orig;
}
-(BOOL)shouldShowLockStatusBarTime{
    if(CLShowStatusBarTime)
        return YES;
    return %orig;
}
-(int)statusBarStyle{
    if(CLSmallStatusBar)
        return 0;
    return %orig;
}

%end
static void loadPrefs(){
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.cvandyke.customlockscreen.plist"];
    if(prefs)
    {
        CLisEnabled = ( [prefs objectForKey:@"CLisEnabled"] ? [[prefs objectForKey:@"CLisEnabled"] boolValue] : CLisEnabled );
        CLtext = ( [prefs objectForKey:@"CLtext"] ? [prefs objectForKey:@"CLtext"] : CLtext );
        CLHideText = ( [prefs objectForKey:@"CLHideText"] ? [[prefs objectForKey:@"CLHideText"] boolValue] : CLHideText );
        CLHideTopGrabber = ( [prefs objectForKey:@"CLHideTopGrabber"] ? [[prefs objectForKey:@"CLHideTopGrabber"] boolValue] : CLHideTopGrabber);
        CLHideBotGrabber = ( [prefs objectForKey:@"CLHideBotGrabber"] ? [[prefs objectForKey:@"CLHideBotGrabber"] boolValue] : CLHideBotGrabber);
        CLHideCamGrabber = ( [prefs objectForKey:@"CLHideCamGrabber"] ? [[prefs objectForKey:@"CLHideCamGrabber"] boolValue] : CLHideCamGrabber);
        CLHideLockDate = ( [prefs objectForKey:@"CLHideLockDate"] ? [[prefs objectForKey:@"CLHideLockDate"] boolValue] : CLHideLockDate);
        CLShowStatusBarTime = ( [prefs objectForKey:@"CLShowStatusBarTime"] ? [[prefs objectForKey:@"CLShowStatusBarTime"] boolValue] : CLShowStatusBarTime);
        CLSmallStatusBar = ( [prefs objectForKey:@"CLSmallStatusBar"] ? [[prefs objectForKey:@"CLSmallStatusBar"] boolValue] : CLSmallStatusBar);
        [CLtext retain];
    }
    [prefs release];
}
static void prefsChanged(CFNotificationCenterRef center,
                                    void *observer,
                                    CFStringRef name,
                                    const void *object,
                                    CFDictionaryRef userInfo)
{
    loadPrefs();
}

%ctor 
{
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(r, NULL, &prefsChanged, CFSTR("com.cvandyke.customlockscreen/loadPrefs"), NULL, 0);
    loadPrefs();
}