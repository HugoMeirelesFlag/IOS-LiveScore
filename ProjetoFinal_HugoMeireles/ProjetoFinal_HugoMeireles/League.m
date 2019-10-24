//
//  League.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 11/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "League.h"

@implementation League

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _leagueId = dictionary[@"id"];
        _leagueName = dictionary[@"name"];
        _leagueCountry = dictionary[@"area"][@"name"];
    }
    return self;
}

@end
