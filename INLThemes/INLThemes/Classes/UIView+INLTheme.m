//
//  INLThemedView.m
//
//  Created by Tomas Hakel on 01/02/2016.
//  Copyright © 2016 Inloop. All rights reserved.
//

#import "UIView+INLTheme.h"
#import "INLAssetService.h"
#import "UIColor+Hex.h"
#import "UIViewController+INLThemeConsumer.h"


@implementation UIView (INLTheme)

synthesizeElementId

- (void)applyTheme:(INLThemeElement *)theme {
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *) self;

        NSString *fontName = [theme valueForKey:@"font"];
        NSString *textSizeValue = [theme valueForKey:@"textSize"];
        CGFloat textSize = label.font.pointSize;

        if (textSizeValue != nil) {
            if (textSizeValue.floatValue > 0.0f) {
                textSize = textSizeValue.floatValue;
            }
        }

        if (fontName != nil) {
            label.font = [UIFont fontWithName:fontName size:textSize];
        }
        else if (textSize != label.font.pointSize) {
            label.font = [label.font fontWithSize:textSize];
        }
    }

    NSString *backgroundColorHex = [theme valueForKey:@"backgroundColor"];
    if (backgroundColorHex) {
        self.backgroundColor = [UIColor colorWithHex:backgroundColorHex];
    }

    NSString *tintColorHex = [theme valueForKey:@"tintColor"];
    if (tintColorHex) {
        self.tintColor = [UIColor colorWithHex:tintColorHex];
    }

    NSNumber *hidden = theme.values[@"hidden"];
    if (hidden) {
        self.hidden = [hidden boolValue];
    }

    NSNumber *alpha = theme.values[@"alpha"];
    if (alpha) {
        self.alpha = [hidden boolValue];
    }

    NSNumber *cornerRadius = theme.values[@"cornerRadius"];
    if (cornerRadius) {
        self.layer.cornerRadius = [cornerRadius floatValue];
    }
}

@end


@implementation NSLayoutConstraint (INLTheme)

synthesizeElementId

-(void)applyTheme:(INLThemeElement *)theme {
    NSNumber *active = theme.values[@"active"];
    if (active) {
        self.active = [active boolValue];
    }

    NSNumber *constant = theme.values[@"constant"];
    if (constant) {
        self.constant = [constant floatValue];
    }

    NSNumber *priority = theme.values[@"priority"];
    if (priority) {
        self.priority = [priority integerValue];
    }
}

@end


@implementation NSObject (INLThemable)

- (BOOL)isThemable {
    return [self conformsToProtocol:@protocol(INLThemedView)]
            && [(id <INLThemedView>) self elementId] != nil;
}

@end
