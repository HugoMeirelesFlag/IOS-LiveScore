//
//  FootballDataAPI.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Developer on 04/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "FootballDataAPI.h"

@implementation FootballDataAPI

- (void)getAllMatchesOfTheDay:(BOOL)isPlay dayOfMatch:(NSDate *)matchDay completionBlock:(void (^)(NSDictionary *, NSError *))completion {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    NSString *dateString = [NSString stringWithFormat:@"https://api.football-data.org/v2/matches?dateFrom=%@&dateTo=%@",[dateFormatter stringFromDate:matchDay],[dateFormatter stringFromDate:matchDay]];
    NSURL *url = [NSURL URLWithString:dateString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"e902ed3d2af34f2bb11d62e9f029e1c4" forHTTPHeaderField:@"X-Auth-Token"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil,error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil,jsonError);
            } else {
                NSArray *matchDictionaries = responseDictionary[@"matches"];
                NSMutableDictionary *leaguesAndMatches = [NSMutableDictionary new];
                for (NSDictionary *matchDictionary in matchDictionaries) {
                    Match *match = [[Match alloc] initWithDictionary:matchDictionary];
                    if( isPlay == YES){
                        if([match.matchStatus isEqualToString:@"IN_PLAY"]){
                            if([leaguesAndMatches objectForKey:match.matchCompetion]){
                                [[leaguesAndMatches objectForKey:match.matchCompetion] addObject:match];
                            }else{
                                [leaguesAndMatches setObject:[NSMutableArray array] forKey:match.matchCompetion];
                                [[leaguesAndMatches objectForKey:match.matchCompetion] addObject:match];
                            }
                        }
                        
                    }else{
                        if([leaguesAndMatches objectForKey:match.matchCompetion]){
                            [[leaguesAndMatches objectForKey:match.matchCompetion] addObject:match];
                        }else{
                            [leaguesAndMatches setObject:[NSMutableArray array] forKey:match.matchCompetion];
                            [[leaguesAndMatches objectForKey:match.matchCompetion] addObject:match];
                        }
                    }
                }
                NSDictionary *leaguesAndMatchesCopy = [NSDictionary dictionaryWithDictionary:leaguesAndMatches];
                completion(leaguesAndMatchesCopy,nil);
            }
        }
    }];
    
    [task resume];
}

- (void)getAllLeaguePositionsForCompetitionWithId:(NSNumber *)competitionId completionBlock:(void (^)(NSDictionary *, NSError *))completion {
    NSString *leagueId = [NSString stringWithFormat:@"https://api.football-data.org/v2/competitions/%@/standings/?standingType=TOTAL",competitionId];
    NSURL *url = [NSURL URLWithString:leagueId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"e902ed3d2af34f2bb11d62e9f029e1c4" forHTTPHeaderField:@"X-Auth-Token"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil,error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil,jsonError);
            } else {
                
                NSArray *leagueDictionaries = responseDictionary[@"standings"];
                NSDictionary *league = [NSDictionary dictionaryWithDictionary:leagueDictionaries[0]];
                NSArray *leagueTable = [league allValues];
                NSMutableDictionary *leaguePositions = [NSMutableDictionary new];
                for (NSDictionary *leaguePositionDictionary in leagueTable[2]) {
                    LeaguePosition *leaguePosition = [[LeaguePosition alloc] initWithDictionary:leaguePositionDictionary];
                    [leaguePositions setObject:leaguePosition forKey:leaguePosition.teamPosition];
                    
                }
                NSDictionary *leaguePositionsCopy = [NSDictionary dictionaryWithDictionary:leaguePositions];
                completion(leaguePositionsCopy,nil);
            }
        }
    }];
    
    [task resume];
}

- (void)getAllLeagues:(void (^)(NSDictionary *, NSError *))completion{
    NSString *leagueId = [NSString stringWithFormat:@"https://api.football-data.org/v2/competitions?plan=TIER_ONE"];
    NSURL *url = [NSURL URLWithString:leagueId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"e902ed3d2af34f2bb11d62e9f029e1c4" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil,error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil,jsonError);
            } else {
                
                NSArray *leagueDictionaries = responseDictionary[@"competitions"];
                NSMutableDictionary *tempDictLeague = [NSMutableDictionary new];
                for (NSDictionary *leagueDictionary in leagueDictionaries) {
                    League *league = [[League alloc] initWithDictionary:leagueDictionary];
                    
                    [tempDictLeague setObject:league forKey:league.leagueId];
                    
                }
                NSDictionary *leagueDictCopy = [NSDictionary dictionaryWithDictionary:tempDictLeague];
                completion(leagueDictCopy,nil);
            }
        }
    }];
    
    [task resume];
}

- (void)getAllTeamMatcheswithId:(NSNumber *)teamId completionBlock:(void (^)(NSDictionary * , NSError * ))completion{
    NSString *leagueUrlId = [NSString stringWithFormat:@"https://api.football-data.org/v2/teams/%@/matches",teamId];
    NSURL *url = [NSURL URLWithString:leagueUrlId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"e902ed3d2af34f2bb11d62e9f029e1c4" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil,error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil,jsonError);
            } else {
                
                NSArray *teamMatchesDictionaries = responseDictionary[@"matches"];
                NSMutableDictionary *tempDictMatches = [NSMutableDictionary new];
                for (NSDictionary *matchDictionary in teamMatchesDictionaries) {
                    Match *match = [[Match alloc] initWithDictionary:matchDictionary];
                    if([tempDictMatches objectForKey:match.matchCompetion]){
                        [[tempDictMatches objectForKey:match.matchCompetion] addObject:match];
                    }else{
                        [tempDictMatches setObject:[NSMutableArray array] forKey:match.matchCompetion];
                        [[tempDictMatches objectForKey:match.matchCompetion] addObject:match];
                    }
                }
                NSDictionary *teamMatchDictCopy = [NSDictionary dictionaryWithDictionary:tempDictMatches];
                completion(teamMatchDictCopy,nil);
            }
        }
    }];
    
    [task resume];
}


- (void)getAllLeagueMatcheswithId:(NSNumber *)leagueId withMatchDay:(NSNumber *)matchDay completionBlock:(void (^)(NSDictionary *, NSError *))completion{
    
    NSString *leagueUrlId = [NSString stringWithFormat:@"https://api.football-data.org/v2/competitions/%@/matches?matchday=%@",leagueId,matchDay];
    NSURL *url = [NSURL URLWithString:leagueUrlId];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:@"e902ed3d2af34f2bb11d62e9f029e1c4" forHTTPHeaderField:@"X-Auth-Token"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error != nil) {
            completion(nil,error);
        } else {
            NSError *jsonError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError != nil) {
                completion(nil,jsonError);
            } else {
                
                NSArray *teamMatchesDictionaries = responseDictionary[@"matches"];
                NSMutableDictionary *tempDictMatches = [NSMutableDictionary new];
                for (NSDictionary *matchDictionary in teamMatchesDictionaries) {
                    Match *match = [[Match alloc] initWithDictionaryMatchDay:matchDictionary];
                    [tempDictMatches setObject:match forKey:match.homeTeam];
                }
                NSDictionary *teamMatchDictCopy = [NSDictionary dictionaryWithDictionary:tempDictMatches];
                completion(teamMatchDictCopy,nil);
            }
        }
    }];
    
    [task resume];
}

@end
