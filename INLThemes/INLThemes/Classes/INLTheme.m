//
//  Theme.m
//
//  Created by Tomas Hakel on 28/01/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "INLTheme.h"
#import "UIColor+Hex.h"


@interface INLTheme () {
    NSDictionary *_colors;
    NSDictionary *_fonts;
}
@end


@implementation INLTheme

#pragma mark -- Initializers

- (instancetype)initWithThemeDict:(NSDictionary *)themeDict {
    if (self = [super init]) {
        _colors = themeDict[@"INLThemeColors"];
        _fonts = themeDict[@"INLThemeFonts"];

        NSMutableDictionary *uiElements = [NSMutableDictionary new];

        for (NSString *elementId in themeDict.keyEnumerator) {
            if ([elementId isEqualToString:@"INLThemeColors"] || [elementId isEqualToString:@"INLThemeFonts"]) {
                continue;
            }

            NSMutableDictionary *values = [themeDict[elementId] mutableCopy];

            for (NSString *key in [themeDict[elementId] keyEnumerator]) {
                if ([@"font" isEqualToString:key] && _fonts[values[key]] != nil) {
                    values[key] = _fonts[values[key]];
                }
                else if (_colors[values[key]] != nil) {
                    values[key] = _colors[values[key]];
                }
            }

            uiElements[elementId] = [INLThemeElement elementWithDictionary:values];
        }

        self.uiElements = uiElements;
    }

    return self;
}

+ (instancetype)themeWithPlist:(NSString *)plistName {
    NSDictionary *themeDict = nil;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];

    if (plistPath) {
        themeDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    }

    return [[INLTheme alloc] initWithThemeDict:themeDict];
}

+ (instancetype)themeWithJSONData:(NSData *)jsonData {
    NSDictionary *themeDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    return [[INLTheme alloc] initWithThemeDict:themeDict];
}

+ (instancetype)themeWithJSONFile:(NSString *)jsonName {
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    return [self themeWithJSONData:[NSData dataWithContentsOfFile:jsonPath]];
}

+ (instancetype)themeWithJSON:(NSString *)json {
    return [self themeWithJSONData:[json dataUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark -- Fonts

- (NSString *__nullable)regularFontName {
    return _fonts[@"regular"];
}

- (NSString *__nullable)boldFontName {
    return _fonts[@"bold"];
}

- (NSString *__nullable)lightFontName {
    return _fonts[@"light"];
}

#pragma mark -- Colors

- (UIColor *)colorWithName:(NSString *__nonnull)colorName {
    NSString *colorString = _colors[colorName];

    if (colorString != nil) {
        // TODO: cache these parsed UIColor objects
        return [UIColor colorWithHex:colorString];
    }

    return nil;
}

- (UIColor *)primaryColor {
    return [self colorWithName:@"primaryColor"];
}

- (UIColor *)primaryDarkColor {
    return [self colorWithName:@"primaryDarkColor"];
}

- (UIColor *)accentColor {
    return [self colorWithName:@"appAccent"];
}

- (UIColor *)textColorPrimary {
    return [self colorWithName:@"textColorPrimary"];
}

- (UIColor *)textColorSecondary {
    return [self colorWithName:@"textColorSecondary"];
}


@end
