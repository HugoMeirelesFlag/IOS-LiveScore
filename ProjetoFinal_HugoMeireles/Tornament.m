//
//  Tornament.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 26/12/2020.
//  Copyright © 2020 Hugo Meireles. All rights reserved.
//

#import "Tornament.h"
#import <UIKit/UIKit.h>

@implementation Tornament

+ (NSString *)getStage:(NSNumber *)MatchDay{
    switch (MatchDay.intValue) {
        case 1:
            return @"1";
        case 2:
            return @"2";
        case 3:
            return @"3";
        case 4:
            return @"4";
        case 5:
            return @"5";
        case 6:
            return @"6";
        case 7:
            return @"ROUND_OF_16";
        case 8:
            return @"QUARTER_FINALS";
        case 9:
            return @"SEMI_FINALS";
        case 10:
            return @"FINALS";
        default:
            return @"1";
    }
}

@end
