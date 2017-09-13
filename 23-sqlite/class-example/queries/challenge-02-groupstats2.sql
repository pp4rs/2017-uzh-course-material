/*
    Partial Solution on using ROUND with Aggregate functions

    Author: @lachlandeer
*/;

SELECT
      AuctionID
    , MIN(Bid)  AS SmallestBid
    , ROUND(AVG(Bid),2)  AS AverageBid
    , MAX(Bid)  AS LargestBid
FROM
    bids
GROUP BY
    AuctionID
;
