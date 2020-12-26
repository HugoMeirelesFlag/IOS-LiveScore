//
//  Match.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "Match.h"

@implementation Match
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _kickOffHour = dictionary[@"utcDate"];
        _homeTeam = dictionary[@"homeTeam"][@"name"];
        _awayTeam = dictionary[@"awayTeam"][@"name"];
        _goalshomeTeam = dictionary[@"score"][@"fullTime"][@"homeTeam"];
        _goalsAwayTeam = dictionary[@"score"][@"fullTime"][@"awayTeam"];
        _matchStatus= dictionary[@"status"];
        _matchCompetion = dictionary[@"competition"][@"name"];
        _matchCompetionId = dictionary[@"competition"][@"id"];
    }
    return self;
}

- (instancetype)initWithDictionaryMatchDay:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _kickOffHour = dictionary[@"utcDate"];
        _homeTeam = dictionary[@"homeTeam"][@"name"];
        _awayTeam = dictionary[@"awayTeam"][@"name"];
        _goalshomeTeam = dictionary[@"score"][@"fullTime"][@"homeTeam"];
        _goalsAwayTeam = dictionary[@"score"][@"fullTime"][@"awayTeam"];
        _matchStatus= dictionary[@"status"];
        _matchDay = dictionary[@"matchday"];
    }
    return self;
}

@end
