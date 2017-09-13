/*
    Demonstrate how to select rows using WHERE condition

    Author: @lachlandeer
*/;

SELECT
      AuctionID
    , Date
    , District
FROM
    auctions
WHERE
    District == 4
;
