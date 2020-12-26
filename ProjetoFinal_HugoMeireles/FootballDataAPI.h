//
//  FootballDataAPI.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Match.h"
#import "LeaguePosition.h"
#import "League.h"

NS_ASSUME_NONNULL_BEGIN

@interface FootballDataAPI : NSObject

- (void)getAllMatchesOfTheDay:(BOOL)isPlay dayOfMatch:(NSDate *)matchDay completionBlock:(void (^)(NSDictionary *, NSError *))completion;

- (void)getAllLeaguePositionsForCompetitionWithId:(NSNumber *)competitionId completionBlock:(void (^)(NSDictionary *, NSError *))completion;

- (void)getAllLeagues:(void (^)(NSDictionary *, NSError *))completion;

- (void)getAllTeamMatcheswithId:(NSNumber *)teamId completionBlock:(void (^)(NSDictionary *, NSError *))completion;

- (void)getAllLeagueMatcheswithId:(NSNumber *)leagueId withMatchDay:(NSNumber *)matchDay completionBlock:(void (^)(NSDictionary *, NSError *))completion;

@end

NS_ASSUME_NONNULL_END
