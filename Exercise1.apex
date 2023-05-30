public class OpportunityUtils {
    public static Decimal calculateAverageOpportunityAmount() {
        // Initialize average amount to 0
        Decimal averageAmount = 0;
        
        // Query all opportunities with the "Closed Won" stage
        List<Opportunity> closedWonOpps = [SELECT Amount FROM Opportunity WHERE StageName = 'Closed Won'];
        
        // Check if there are any closed-won opportunities
        if (closedWonOpps.size() > 0) {
            // Initialize total amount to 0
            Decimal totalAmount = 0;
            
            // Loop through each opportunity and add its amount to the total amount
            for (Opportunity opp : closedWonOpps) {
                totalAmount += opp.Amount;
            }
            
            // Calculate the average amount by dividing the total amount by the number of opportunities
            averageAmount = totalAmount / closedWonOpps.size();
        }
        
        // Return the calculated average amount
        return averageAmount;
    }
}
