//
//  Match.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 03/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Match : NSObject
@property (strong,nonatomic,readonly) NSString *kickOffHour;
@property (strong,nonatomic,readonly) NSString *homeTeam;
@property (strong,nonatomic,readonly) NSString *awayTeam;
@property (strong,nonatomic,readonly) NSNumber *goalshomeTeam;
@property (strong,nonatomic,readonly) NSNumber *goalsAwayTeam;
@property (strong,nonatomic,readonly) NSString *matchStatus;
@property (strong,nonatomic,readonly) NSString *matchCompetion;
@property (strong,nonatomic,readonly) NSNumber *matchCompetionId;
@property (strong,nonatomic,readonly) NSNumber *matchDay;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithDictionaryMatchDay:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
