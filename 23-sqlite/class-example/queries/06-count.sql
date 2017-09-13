/*
    Demonstrate how to use an Aggregate function, and introduces aliasing

    Author: @lachlandeer
*/;

SELECT
      COUNT(*)      AS nBids
    , bidderID
FROM
    bids
GROUP BY
    bidderID
;
