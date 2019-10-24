//
//  FavoritosManager.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Developer on 09/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "FavoriteMO+CoreDataProperties.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavoritesManager : NSObject

+ (BOOL)createFavoriteWithTeamId:(NSNumber *)teamId
                        TeamName:(NSString *)teamName
                        WithTeamCompetition :(NSString *)CompetitionName;

+ (NSArray <FavoriteMO *> *)allFavorites;

+ (BOOL)isFavorite:(NSNumber *)teamId;

+ (BOOL)isFavoriteWithName:(NSString *)teamName;



+ (BOOL)isFavoriteWithCompetition:(NSString *)competitionName;

+(void)deleteFavorite:(NSNumber *)teamId;

+(void)deletedata;

@end

NS_ASSUME_NONNULL_END
