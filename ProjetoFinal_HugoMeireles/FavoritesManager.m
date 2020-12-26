//
//  FavoritosManager.m
//  ProjetoFinal_HugoMeireles
//
//  Created by Developer on 09/05/2019.
//  Copyright © 2019 Hugo Meireles. All rights reserved.
//

#import "FavoritesManager.h"
#import "AppDelegate.h"

@implementation FavoritesManager

+ (BOOL)createFavoriteWithTeamId:(NSNumber *)teamId
                        TeamName:(NSString *)teamName
            WithTeamCompetition :(NSString *)CompetitionName{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    FavoriteMO *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"Favorite" inManagedObjectContext:context];
    favorite.teamId = [teamId intValue];
    favorite.teamName = teamName;
    favorite.competitionName = CompetitionName;
    
    return [appDelegate saveContext];
}

+ (NSArray <FavoriteMO *> *)allFavorites {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *favoritesFetch = [FavoriteMO fetchRequest];
    NSSortDescriptor *competitionNameSort = [NSSortDescriptor sortDescriptorWithKey:@"competitionName" ascending:YES];
    NSSortDescriptor *teamNameSort = [NSSortDescriptor sortDescriptorWithKey:@"teamName" ascending:YES];
    favoritesFetch.sortDescriptors = @[competitionNameSort, teamNameSort];
    
    NSArray <FavoriteMO *> *favorites = [context executeFetchRequest:favoritesFetch error:nil];
    return favorites;
}

+ (BOOL)isFavorite:(NSNumber *)teamId{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *favoritesFetch = [FavoriteMO fetchRequest];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"(teamId == %@)",
                              teamId];
    favoritesFetch.predicate = predicate;
    if([[context executeFetchRequest:favoritesFetch error:nil] count] != 0){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)isFavoriteWithName:(NSString *)teamName{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *favoritesFetch = [FavoriteMO fetchRequest];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"(teamName like %@)",
                              teamName];
    favoritesFetch.predicate = predicate;
    if([[context executeFetchRequest:favoritesFetch error:nil] count] != 0){
        return YES;
    }else{
        return NO;
    }
}




+ (BOOL)isFavoriteWithCompetition:(NSString *)competitionName{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *favoritesFetch = [FavoriteMO fetchRequest];
    
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"(competitionName like %@)",
                              competitionName];
    favoritesFetch.predicate = predicate;
    if([[context executeFetchRequest:favoritesFetch error:nil] count] != 0){
        return YES;
    }else{
        return NO;
    }
}

+ (void)deleteFavorite:(NSNumber *)teamId{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest *favoritesFetch = [FavoriteMO fetchRequest];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:context];
    NSPredicate *predicate = [NSPredicate
                              predicateWithFormat:@"(teamId == %@)",
                              teamId];
    [favoritesFetch setEntity:entity];
    [favoritesFetch setPredicate:predicate];
    
    NSError *error;
    NSArray *favorites = [context executeFetchRequest:favoritesFetch error:&error];
    
    for (NSManagedObject *managedObject in favorites)
    {
        [context deleteObject:managedObject];
    }
    [context save:nil];
}

+(void)deletedata{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest *fetchRequest = [FavoriteMO fetchRequest];
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favorite" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [context deleteObject:managedObject];
    }
    [context save:nil];
}

@end
