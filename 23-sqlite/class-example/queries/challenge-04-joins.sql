/*
    Partial Solution showing how to use INNER JOIN to link data across
        tables

    Author: @lachlandeer
*/;

SELECT
      bidders.FirstName
    , bidders.LastName
    , MIN(bids.Bid)           AS SmallestBid
    , ROUND(AVG(bids.Bid),2)  AS AverageBid
    , MAX(bids.Bid)           AS LargestBid
FROM
    bids
INNER JOIN
    bidders
ON
    bidders.BidderID = bids.BidderID
GROUP BY
      bids.BidderID
;
