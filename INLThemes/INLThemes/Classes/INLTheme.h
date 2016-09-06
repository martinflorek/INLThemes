//
//  Theme.h
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INLThemeElement.h"

@interface INLTheme : NSObject

@property (strong, nonatomic) NSDictionary<NSString *, INLThemeElement *> * __nonnull uiElements;

+(instancetype __nonnull)themeWithPlist:(NSString * __nonnull)plistName;
+(instancetype __nonnull)themeWithJSONData:(NSData * __nonnull)jsonData;
+(instancetype __nonnull)themeWithJSONFile:(NSString * __nonnull)jsonName;
+(instancetype __nonnull)themeWithJSON:(NSString * __nonnull)json;

// Fonts
- (NSString * __nullable)regularFontName;
- (NSString * __nullable)boldFontName;
- (NSString * __nullable)lightFontName;

// Colors
- (UIColor * __nullable)colorWithName:(NSString * __nonnull)colorName;
- (UIColor * __nullable)primaryColor;
- (UIColor * __nullable)primaryDarkColor;
- (UIColor * __nullable)accentColor;
- (UIColor * __nullable)textColorPrimary;
- (UIColor * __nullable)textColorSecondary;


@end
