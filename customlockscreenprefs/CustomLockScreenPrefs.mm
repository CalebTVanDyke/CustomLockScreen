#import <Preferences/Preferences.h>

@interface CustomLockScreenPrefsListController: PSListController {
}
@end

@implementation CustomLockScreenPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"CustomLockScreenPrefs" target:self] retain];
	}
	return _specifiers;
}
-(void) twitter
{

	NSURL *safariURL = [NSURL URLWithString:@"https://twitter.com/Caleb_VanDyke"];
	NSURL *twitterURL = [NSURL URLWithString:@"twitter://user?screen_name=Caleb_VanDyke"];

	if (![[UIApplication sharedApplication] openURL:twitterURL])
		if( ![[UIApplication sharedApplication] openURL:safariURL])
			NSLog(@"%@%@",@"Failed to open url:",[safariURL description]);
}

-(void) github
{
	NSURL *url = [NSURL URLWithString:@"http://github.com/CalebTVanDyke"];

	if (![[UIApplication sharedApplication] openURL:url])
		NSLog(@"%@%@",@"Failed to open url:",[url description]);
}
-(void) email
{
	NSURL *url = [NSURL URLWithString:@"mailto:ctvandyke24@gmail.com?subject=CustomLockScreen"];
	if (![[UIApplication sharedApplication] openURL:url])
		NSLog(@"%@%@",@"Failed to open url:",[url description]);
}
-(void) reset
{
	
}
@end

// vim:ft=objc
