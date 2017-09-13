/*
    Partial Solution on Using Aggregate Functions to compute
        group statistics

    Author: @lachlandeer
*/;

SELECT
      BidderID
    , MIN(Bid)  AS SmallestBid
    , AVG(Bid)  AS AverageBid
    , MAX(Bid)  AS LargestBid
FROM
    bids
GROUP BY
    bids.BidderID
;
