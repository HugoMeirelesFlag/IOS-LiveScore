//
//  LeaguePosition.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LeaguePosition : NSObject

@property (strong,nonatomic) NSNumber *teamId;
@property (strong,nonatomic) NSNumber *teamPosition;
@property (strong,nonatomic) NSString *teamName;
@property (strong,nonatomic) NSNumber *teamPoints;
@property (strong,nonatomic) NSNumber *teamPlayedGames;
@property (strong,nonatomic) NSNumber *teamWon;
@property (strong,nonatomic) NSNumber *teamDraw;
@property (strong,nonatomic) NSNumber *teamLost;
@property (strong,nonatomic) NSNumber *teamGoalsFor;
@property (strong,nonatomic) NSNumber *teamGoalsAgainst;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
