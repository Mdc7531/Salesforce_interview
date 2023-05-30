public class OpportunityMetrics {
    public static Map<String, Decimal> calculateOpportunityWinRatesByStage() {
        // Initialize win rates map
        Map<String, Decimal> winRatesByStage = new Map<String, Decimal>();
        
        // Query all opportunities and group by stage name
        List<AggregateResult> oppsByStage = [SELECT StageName, COUNT(Id) oppCount FROM Opportunity GROUP BY StageName];
        
        // Initialize map to store total opportunities by stage
        Map<String, Integer> totalOppsByStage = new Map<String, Integer>();
        
        // Loop through each stage and store the total number of opportunities
        for (AggregateResult ar : oppsByStage) {
            String stageName = (String) ar.get('StageName');
            Integer oppCount = (Integer) ar.get('oppCount');
            totalOppsByStage.put(stageName, oppCount);
        }
        
        // Query all closed-won opportunities and group by stage name
        List<AggregateResult> closedWonOppsByStage = [SELECT StageName, COUNT(Id) oppCount FROM Opportunity WHERE StageName = 'Closed Won' GROUP BY StageName];
        
        // Loop through each stage and calculate the win rate
        for (AggregateResult ar : closedWonOppsByStage) {
            String stageName = (String) ar.get('StageName');
            Integer closedWonOppCount = (Integer) ar.get('oppCount');
            Integer totalOppCount = totalOppsByStage.get(stageName);
            Decimal winRate = 0;
            if (totalOppCount > 0) {
                winRate = ((Decimal) closedWonOppCount / totalOppCount).setScale(2);
            }
            winRatesByStage.put(stageName, winRate);
        }
        
        // Return the calculated win rates by stage
        return winRatesByStage;
    }
}
