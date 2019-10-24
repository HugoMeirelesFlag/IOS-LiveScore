//
//  LeaguePosition.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "LeaguePosition.h"

@implementation LeaguePosition
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        _teamId = dictionary[@"team"][@"id"];
        _teamPosition= dictionary[@"position"];
        _teamName = dictionary[@"team"][@"name"];
        _teamPlayedGames = dictionary[@"playedGames"];
        _teamPoints = dictionary[@"points"];
        _teamWon = dictionary[@"won"];
        _teamDraw = dictionary[@"draw"];
        _teamLost = dictionary[@"lost"];
        _teamGoalsFor = dictionary[@"goalsFor"];
        _teamGoalsAgainst = dictionary[@"goalsAgainst"];
        
    }
    return self;
}
@end
