/*
    Partial solution on filtering based on group stats produced
        by aggregate functions

    Author: @lachlandeer
*/;

SELECT
      bidderID
    , MIN(Bid)  AS SmallestBid
    , ROUND(AVG(Bid),2)  AS AverageBid
    , MAX(Bid)  AS LargestBid
FROM
    bids
WHERE
    bidderID % 2 == 0
GROUP BY
    bidderID
HAVING
    AverageBid > 11
;
