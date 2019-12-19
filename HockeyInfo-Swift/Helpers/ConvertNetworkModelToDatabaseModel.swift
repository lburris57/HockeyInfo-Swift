//
//  ConvertNetworkModelToDatabaseModel.swift
//  HockeyInfo-Swift
//
//  Created by Larry Burris on 12/16/19.
//  Copyright © 2019 Larry Burris. All rights reserved.
//
import Foundation

struct ConvertNetworkModelToDatabaseModel
{
    func convertSeasonScheduleToNHLScheduleList(_ seasonSchedule: SeasonSchedule) -> [NHLSchedule]
    {
        var nhlScheduleList = [NHLSchedule]()
        
        for scheduledGame in seasonSchedule.gameList
        {
            let nhlSchedule = NHLSchedule()

            let startTime = scheduledGame.scheduleInfo.startTime
            let lastUpdatedOn = seasonSchedule.lastUpdatedOn

            nhlSchedule.id = scheduledGame.scheduleInfo.id
            nhlSchedule.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            nhlSchedule.lastUpdatedOn = "\(TimeAndDateUtils.getDate(lastUpdatedOn)) at \(TimeAndDateUtils.getTime(lastUpdatedOn))"
            nhlSchedule.date = TimeAndDateUtils.getDate(startTime)
            nhlSchedule.time = TimeAndDateUtils.getTime(startTime)
            nhlSchedule.homeTeam = scheduledGame.scheduleInfo.homeTeamInfo.abbreviation
            nhlSchedule.awayTeam = scheduledGame.scheduleInfo.awayTeamInfo.abbreviation
            nhlSchedule.homeScoreTotal = scheduledGame.scoreInfo.homeScoreTotal ?? 0
            nhlSchedule.awayScoreTotal = scheduledGame.scoreInfo.awayScoreTotal ?? 0
            nhlSchedule.homeShotsTotal = scheduledGame.scoreInfo.homeShotsTotal ?? 0
            nhlSchedule.awayShotsTotal = scheduledGame.scoreInfo.awayShotsTotal ?? 0
            nhlSchedule.playedStatus = scheduledGame.scheduleInfo.playedStatus
            nhlSchedule.scheduleStatus = scheduledGame.scheduleInfo.scheduleStatus
            nhlSchedule.numberOfPeriods = scheduledGame.scoreInfo.periodList?.count ?? 0
            nhlSchedule.currentPeriod = scheduledGame.scoreInfo.currentPeriod ?? 0
            nhlSchedule.currentTimeRemaining = scheduledGame.scoreInfo.currentPeriodSecondsRemaining ?? 0

            nhlScheduleList.append(nhlSchedule)
        }
        
        return nhlScheduleList
    }
    
    func convertRosterPlayersToNHLPlayerList(_ rosterPlayers: RosterPlayers) -> [NHLPlayer]
    {
        var playerList = [NHLPlayer]()
        
        for playerInfo in rosterPlayers.playerInfoList
        {
            let nhlPlayer = NHLPlayer()
            
            nhlPlayer.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            nhlPlayer.id = playerInfo.player.id
            nhlPlayer.firstName = playerInfo.player.firstName
            nhlPlayer.lastName = playerInfo.player.lastName
            nhlPlayer.age = String(playerInfo.player.age ?? 0)
            nhlPlayer.birthDate = playerInfo.player.birthDate ?? ""
            nhlPlayer.birthCity = playerInfo.player.birthCity ?? ""
            nhlPlayer.birthCountry = playerInfo.player.birthCountry ?? ""
            nhlPlayer.height = playerInfo.player.height ?? ""
            nhlPlayer.weight = String(playerInfo.player.weight ?? 0)
            nhlPlayer.jerseyNumber = String(playerInfo.player.jerseyNumber ?? 0)
            nhlPlayer.imageURL = playerInfo.player.officialImageSource?.absoluteString ?? ""
            nhlPlayer.position = playerInfo.player.position ?? ""
            nhlPlayer.shoots = playerInfo.player.handednessInfo?.shoots ?? ""
            nhlPlayer.teamId = playerInfo.currentTeamInfo?.id ?? 0
            nhlPlayer.teamAbbreviation = playerInfo.currentTeamInfo?.abbreviation ?? ""
            
            playerList.append(nhlPlayer)
        }
        
        return playerList
    }
    
    func convertPlayerStatsToPlayerStatisticsList(_ playerStatsTotalList: [PlayerStatsTotal]) -> [PlayerStatistics]
    {
        var playerStatisticsList = [PlayerStatistics]()
        
        for playerStatsTotal in playerStatsTotalList
        {
            let playerStatistics = PlayerStatistics()
            
            playerStatistics.id = (playerStatsTotal.player?.id)!
            playerStatistics.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            playerStatistics.gamesPlayed = playerStatsTotal.playerStats?.gamesPlayed ?? 0
            playerStatistics.goals = playerStatsTotal.playerStats?.scoringData?.goals ?? 0
            playerStatistics.assists = playerStatsTotal.playerStats?.scoringData?.assists ?? 0
            playerStatistics.points = playerStatsTotal.playerStats?.scoringData?.points ?? 0
            playerStatistics.hatTricks = playerStatsTotal.playerStats?.scoringData?.hatTricks ?? 0
            playerStatistics.powerplayGoals = playerStatsTotal.playerStats?.scoringData?.powerplayGoals ?? 0
            playerStatistics.powerplayAssists = playerStatsTotal.playerStats?.scoringData?.powerplayAssists ?? 0
            playerStatistics.powerplayPoints = playerStatsTotal.playerStats?.scoringData?.powerplayPoints ?? 0
            playerStatistics.shortHandedGoals = playerStatsTotal.playerStats?.scoringData?.shorthandedGoals ?? 0
            playerStatistics.shortHandedAssists = playerStatsTotal.playerStats?.scoringData?.shorthandedAssists ?? 0
            playerStatistics.shortHandedPoints = playerStatsTotal.playerStats?.scoringData?.shorthandedPoints ?? 0
            playerStatistics.gameWinningGoals = playerStatsTotal.playerStats?.scoringData?.gameWinningGoals ?? 0
            playerStatistics.gameTyingGoals = playerStatsTotal.playerStats?.scoringData?.gameTyingGoals ?? 0
            playerStatistics.plusMinus = playerStatsTotal.playerStats?.skatingData?.plusMinus ?? 0
            playerStatistics.shots = playerStatsTotal.playerStats?.skatingData?.shots ?? 0
            playerStatistics.shotPercentage = playerStatsTotal.playerStats?.skatingData?.shotPercentage ?? 0.0
            playerStatistics.blockedShots = playerStatsTotal.playerStats?.skatingData?.blockedShots ?? 0
            playerStatistics.hits = playerStatsTotal.playerStats?.skatingData?.hits ?? 0
            playerStatistics.faceoffs = playerStatsTotal.playerStats?.skatingData?.faceoffs ?? 0
            playerStatistics.faceoffWins = playerStatsTotal.playerStats?.skatingData?.faceoffWins ?? 0
            playerStatistics.faceoffLosses = playerStatsTotal.playerStats?.skatingData?.faceoffLosses ?? 0
            playerStatistics.faceoffPercent = playerStatsTotal.playerStats?.skatingData?.faceoffPercent ?? 0.0
            playerStatistics.penalties = playerStatsTotal.playerStats?.penaltyData?.penalties ?? 0
            playerStatistics.penaltyMinutes = playerStatsTotal.playerStats?.penaltyData?.penaltyMinutes ?? 0
            playerStatistics.wins = playerStatsTotal.playerStats?.goaltendingData?.wins ?? 0
            playerStatistics.losses = playerStatsTotal.playerStats?.goaltendingData?.losses ?? 0
            playerStatistics.overtimeWins = playerStatsTotal.playerStats?.goaltendingData?.overtimeWins ?? 0
            playerStatistics.overtimeLosses = playerStatsTotal.playerStats?.goaltendingData?.overtimeLosses ?? 0
            playerStatistics.goalsAgainst = playerStatsTotal.playerStats?.goaltendingData?.goalsAgainst ?? 0
            playerStatistics.shotsAgainst = playerStatsTotal.playerStats?.goaltendingData?.shotsAgainst ?? 0
            playerStatistics.saves = playerStatsTotal.playerStats?.goaltendingData?.saves ?? 0
            playerStatistics.goalsAgainstAverage = playerStatsTotal.playerStats?.goaltendingData?.goalsAgainstAverage ?? 0.0
            playerStatistics.savePercentage = playerStatsTotal.playerStats?.goaltendingData?.savePercentage ?? 0.0
            playerStatistics.shutouts = playerStatsTotal.playerStats?.goaltendingData?.shutouts ?? 0
            playerStatistics.gamesStarted = playerStatsTotal.playerStats?.goaltendingData?.gamesStarted ?? 0
            playerStatistics.creditForGame = playerStatsTotal.playerStats?.goaltendingData?.creditForGame ?? 0
            playerStatistics.minutesPlayed = playerStatsTotal.playerStats?.goaltendingData?.minutesPlayed ?? 0
            
            playerStatisticsList.append(playerStatistics)
        }
        
        return playerStatisticsList
    }
    
    func convertPlayerInjuriesToNHLPlayerInjuryList(_ playerInjuries: PlayerInjuries) -> [NHLPlayerInjury]
    {
        var nhlPlayerInjuryList = [NHLPlayerInjury]()
        
        for playerInfo in playerInjuries.playerInjuryInfoList
        {
            let playerInjury = NHLPlayerInjury()
            let playerId = playerInfo.id

            playerInjury.id = playerId
            playerInjury.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            playerInjury.teamId = playerInfo.currentTeamInfo?.id ?? 0
            playerInjury.teamAbbreviation = playerInfo.currentTeamInfo?.abbreviation ?? ""
            playerInjury.firstName = playerInfo.firstName
            playerInjury.lastName = playerInfo.lastName
            playerInjury.position = playerInfo.position ?? ""
            playerInjury.jerseyNumber = String(playerInfo.jerseyNumber ?? 0)
            playerInjury.injuryDescription = playerInfo.currentInjuryInfo?.description ?? ""
            playerInjury.playingProbablity = playerInfo.currentInjuryInfo?.playingProbability ?? ""
            
            nhlPlayerInjuryList.append(playerInjury)
        }
        
        return nhlPlayerInjuryList
    }
    
    func convertNHLStandingsToTeamStandingsList(_ nhlStandings: NHLStandings) -> [TeamStandings]
    {
        var teamStandingsList = [TeamStandings]()
        
        for teamStandingsData in nhlStandings.teamList
        {
            let teamStandings = TeamStandings()
            
            //  Populate the Team Standings table
            teamStandings.id = teamStandingsData.teamInformation.id
            teamStandings.abbreviation = teamStandingsData.teamInformation.abbreviation
            teamStandings.division = teamStandingsData.divisionRankInfo.divisionName
            teamStandings.divisionRank = teamStandingsData.divisionRankInfo.rank
            teamStandings.conference = teamStandingsData.conferenceRankInfo.conferenceName
            teamStandings.conferenceRank = teamStandingsData.conferenceRankInfo.rank
            teamStandings.gamesPlayed = teamStandingsData.teamStats.gamesPlayed
            teamStandings.wins = teamStandingsData.teamStats.standingsInfo.wins
            teamStandings.losses = teamStandingsData.teamStats.standingsInfo.losses
            teamStandings.overtimeLosses = teamStandingsData.teamStats.standingsInfo.overtimeLosses
            teamStandings.points = teamStandingsData.teamStats.standingsInfo.points
            teamStandings.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            
            teamStandingsList.append(teamStandings)
        }
        
        return teamStandingsList
    }
    
    func convertNHLStandingsToTeamStatisticsList(_ nhlStandings: NHLStandings) -> [TeamStatistics]
    {
        var teamStatisticsList = [TeamStatistics]()
        
        for teamStandingsData in nhlStandings.teamList
        {
            let teamStatistics = TeamStatistics()
            
            teamStatistics.id = teamStandingsData.teamInformation.id
            teamStatistics.abbreviation = teamStandingsData.teamInformation.abbreviation
            teamStatistics.gamesPlayed = teamStandingsData.teamStats.gamesPlayed
            teamStatistics.wins = teamStandingsData.teamStats.standingsInfo.wins
            teamStatistics.losses = teamStandingsData.teamStats.standingsInfo.losses
            teamStatistics.overtimeLosses = teamStandingsData.teamStats.standingsInfo.overtimeLosses
            teamStatistics.points = teamStandingsData.teamStats.standingsInfo.points
            teamStatistics.powerplays = teamStandingsData.teamStats.powerplayInfo.powerplays
            teamStatistics.powerplayGoals = teamStandingsData.teamStats.powerplayInfo.powerplayGoals
            teamStatistics.powerplayPercent = teamStandingsData.teamStats.powerplayInfo.powerplayPercent
            teamStatistics.penaltyKills = teamStandingsData.teamStats.powerplayInfo.penaltyKills
            teamStatistics.penaltyKillGoalsAllowed = teamStandingsData.teamStats.powerplayInfo.penaltyKillGoalsAllowed
            teamStatistics.penaltyKillPercent = teamStandingsData.teamStats.powerplayInfo.penaltyKillPercent
            teamStatistics.goalsFor = teamStandingsData.teamStats.miscellaneousInfo.goalsFor
            teamStatistics.goalsAgainst = teamStandingsData.teamStats.miscellaneousInfo.goalsAgainst
            teamStatistics.shots = teamStandingsData.teamStats.miscellaneousInfo.shots
            teamStatistics.penalties = teamStandingsData.teamStats.miscellaneousInfo.penalties
            teamStatistics.penaltyMinutes = teamStandingsData.teamStats.miscellaneousInfo.penaltyMinutes
            teamStatistics.hits = teamStandingsData.teamStats.miscellaneousInfo.hits
            teamStatistics.faceoffWins = teamStandingsData.teamStats.faceoffInfo.faceoffWins
            teamStatistics.faceoffLosses = teamStandingsData.teamStats.faceoffInfo.faceoffLosses
            teamStatistics.faceoffPercent = teamStandingsData.teamStats.faceoffInfo.faceoffPercent
            teamStatistics.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            
            teamStatisticsList.append(teamStatistics)
        }
        
        return teamStatisticsList
    }
    
    func convertNHLStandingsToNHLTeamList(_ nhlStandings: NHLStandings) -> [NHLTeam]
    {
        var teamList = [NHLTeam]()
        
        for teamStandingsData in nhlStandings.teamList
        {
            let nhlTeam = NHLTeam()
            
            nhlTeam.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            nhlTeam.id = teamStandingsData.teamInformation.id
            nhlTeam.abbreviation = teamStandingsData.teamInformation.abbreviation
            nhlTeam.city = teamStandingsData.teamInformation.city
            nhlTeam.name = teamStandingsData.teamInformation.name
            nhlTeam.division = teamStandingsData.divisionRankInfo.divisionName
            nhlTeam.conference = teamStandingsData.conferenceRankInfo.conferenceName
            
            teamList.append(nhlTeam)
        }
        
        return teamList
    }
    
    func convertGameLogToNHLGameLogList(_ gameLog: GameLog) -> [NHLGameLog]
    {
        var gameLogDictionary = [Int:NHLGameLog]()
        var gameLogList = [NHLGameLog]()
        
        let lastUpdatedOn = gameLog.lastUpdatedOn
        
        for gameLogData in gameLog.gameLogDataList
        {
            var nhlGameLog: NHLGameLog
        
            var found = false
        
            let gameId = gameLogData.game.id
            let teamAbbreviation = gameLogData.team.abbreviation
        
            //  If game id is found in the dictionary, update that object,
            //  otherwise, create a new one to be inserted
            if gameLogDictionary.keys.contains(gameId)
            {
                found = true
                
                nhlGameLog = gameLogDictionary[gameId]!
            }
            else
            {
                nhlGameLog = NHLGameLog()
                nhlGameLog.id = gameId
            }
        
            let timeString = gameLogData.game.startTime
        
            nhlGameLog.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
            nhlGameLog.lastUpdatedOn = lastUpdatedOn
            nhlGameLog.date = TimeAndDateUtils.getDate(timeString)
            nhlGameLog.time = TimeAndDateUtils.getTime(timeString)
            nhlGameLog.playedStatus = PlayedStatusEnum.completed.rawValue
        
            //  If the game log is the home team, update the home team information,
            //  otherwise, update the away team information
            if gameLogData.game.homeTeamAbbreviation == teamAbbreviation
            {
                nhlGameLog.homeTeamId = gameLogData.team.id
                nhlGameLog.homeTeamAbbreviation = gameLogData.game.homeTeamAbbreviation
                nhlGameLog.homeWins = gameLogData.stats.standings.wins
                nhlGameLog.homeLosses = gameLogData.stats.standings.losses
                nhlGameLog.homeOvertimeWins = gameLogData.stats.standings.overtimeWins
                nhlGameLog.homeOvertimeLosses = gameLogData.stats.standings.overtimeLosses
                nhlGameLog.homePoints = gameLogData.stats.standings.points
                nhlGameLog.homeFaceoffWins = gameLogData.stats.faceoffs.faceoffWins
                nhlGameLog.homeFaceoffLosses = gameLogData.stats.faceoffs.faceoffLosses
                nhlGameLog.homeFaceoffPercent = gameLogData.stats.faceoffs.faceoffPercent
                nhlGameLog.homePowerplays = gameLogData.stats.powerplay.powerplays
                nhlGameLog.homePowerplayGoals = gameLogData.stats.powerplay.powerplayGoals
                nhlGameLog.homePowerplayPercent = gameLogData.stats.powerplay.powerplayPercent
                nhlGameLog.homePenaltyKills = gameLogData.stats.powerplay.penaltyKills
                nhlGameLog.homePenaltyKillGoalsAllowed = gameLogData.stats.powerplay.penaltyKillGoalsAllowed
                nhlGameLog.homePenaltyKillPercent = gameLogData.stats.powerplay.penaltyKillPercent
                nhlGameLog.homeGoalsFor = gameLogData.stats.miscellaneous.goalsFor
                nhlGameLog.homeGoalsAgainst = gameLogData.stats.miscellaneous.goalsAgainst
                nhlGameLog.homeShots = gameLogData.stats.miscellaneous.shots
                nhlGameLog.homePenalties = gameLogData.stats.miscellaneous.penalties
                nhlGameLog.homePenaltyMinutes = gameLogData.stats.miscellaneous.penaltyMinutes
                nhlGameLog.homeHits = gameLogData.stats.miscellaneous.hits
            }
            else if gameLogData.game.awayTeamAbbreviation == teamAbbreviation
            {
                nhlGameLog.awayTeamId = gameLogData.team.id
                nhlGameLog.awayTeamAbbreviation = gameLogData.game.awayTeamAbbreviation
                nhlGameLog.awayWins = gameLogData.stats.standings.wins
                nhlGameLog.awayLosses = gameLogData.stats.standings.losses
                nhlGameLog.awayOvertimeWins = gameLogData.stats.standings.overtimeWins
                nhlGameLog.awayOvertimeLosses = gameLogData.stats.standings.overtimeLosses
                nhlGameLog.awayPoints = gameLogData.stats.standings.points
                nhlGameLog.awayFaceoffWins = gameLogData.stats.faceoffs.faceoffWins
                nhlGameLog.awayFaceoffLosses = gameLogData.stats.faceoffs.faceoffLosses
                nhlGameLog.awayFaceoffPercent = gameLogData.stats.faceoffs.faceoffPercent
                nhlGameLog.awayPowerplays = gameLogData.stats.powerplay.powerplays
                nhlGameLog.awayPowerplayGoals = gameLogData.stats.powerplay.powerplayGoals
                nhlGameLog.awayPowerplayPercent = gameLogData.stats.powerplay.powerplayPercent
                nhlGameLog.awayPenaltyKills = gameLogData.stats.powerplay.penaltyKills
                nhlGameLog.awayPenaltyKillGoalsAllowed = gameLogData.stats.powerplay.penaltyKillGoalsAllowed
                nhlGameLog.awayPenaltyKillPercent = gameLogData.stats.powerplay.penaltyKillPercent
                nhlGameLog.awayGoalsFor = gameLogData.stats.miscellaneous.goalsFor
                nhlGameLog.awayGoalsAgainst = gameLogData.stats.miscellaneous.goalsAgainst
                nhlGameLog.awayShots = gameLogData.stats.miscellaneous.shots
                nhlGameLog.awayPenalties = gameLogData.stats.miscellaneous.penalties
                nhlGameLog.awayPenaltyMinutes = gameLogData.stats.miscellaneous.penaltyMinutes
                nhlGameLog.awayHits = gameLogData.stats.miscellaneous.hits
            }
        
            //  If object was not found, add the created object to the dictionary
            if !found
            {
                gameLogDictionary[gameId] = nhlGameLog
            }
        
            //  Add the game log to the gameLogList
            gameLogList.append(nhlGameLog)
        }
        
        return gameLogList
    }
    
    func convertScoringSummaryToNHLScoringSummary(_ scoringSummary: ScoringSummary) -> NHLScoringSummary
    {
        let nhlScoringSummary = NHLScoringSummary()
        
        let gameId = scoringSummary.game.id
        
        nhlScoringSummary.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
        nhlScoringSummary.id = gameId
        nhlScoringSummary.gameId = gameId
        nhlScoringSummary.playedStatus = scoringSummary.game.playedStatus
        nhlScoringSummary.homeTeamAbbreviation = scoringSummary.game.homeTeam.abbreviation
        nhlScoringSummary.awayTeamAbbreviation = scoringSummary.game.awayTeam.abbreviation
        nhlScoringSummary.homeScoreTotal = scoringSummary.scoringInfo.homeScoreTotal
        nhlScoringSummary.awayScoreTotal = scoringSummary.scoringInfo.awayScoreTotal
        nhlScoringSummary.numberOfPeriods = scoringSummary.scoringInfo.periodList.count
        
        return nhlScoringSummary
    }
    
    func convertScoringSummaryToNHLPeriodScoringDataList(_ scoringSummary: ScoringSummary, maxValue: Int) -> [NHLPeriodScoringData]
    {
        var nhlPeriodScoringDataList = [NHLPeriodScoringData]()
        
        let gameId = scoringSummary.game.id
        
        var max = maxValue
        
        for periodScoringData in scoringSummary.scoringInfo.periodList
        {
            for scoringPlay in periodScoringData.scoringPlays
            {
                let nhlPeriodScoringData = NHLPeriodScoringData()
                
                nhlPeriodScoringData.dateCreated = TimeAndDateUtils.getCurrentDateAsString()
                nhlPeriodScoringData.id = max + 1
                nhlPeriodScoringData.gameId = gameId
                nhlPeriodScoringData.periodNumber = periodScoringData.periodNumber
                nhlPeriodScoringData.teamAbbreviation = scoringPlay.team.abbreviation
                nhlPeriodScoringData.periodSecondsElapsed = scoringPlay.periodSecondsElapsed
                nhlPeriodScoringData.playDescription = scoringPlay.playDescription
                
                max += 1
                
                nhlPeriodScoringDataList.append(nhlPeriodScoringData)
            }
        }
        
        return nhlPeriodScoringDataList
    }
}
