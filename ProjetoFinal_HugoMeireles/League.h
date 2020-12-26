//
//  League.h
//  ProjetoFinal_HugoMeireles
//
//  Created by Hugo Meireles on 11/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface League : NSObject

@property (strong,nonatomic) NSNumber *leagueId;
@property (strong,nonatomic) NSString *leagueName;
@property (strong,nonatomic) NSString *leagueCountry;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


