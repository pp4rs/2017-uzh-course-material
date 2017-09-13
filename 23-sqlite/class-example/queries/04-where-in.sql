/*
    Demonstrate how to select rows using WHERE with IN for
            multiple conditions

        Author: @lachlandeer
*/;

SELECT
      AuctionID
    , Date
    , District
FROM
    auctions
WHERE
    District IN (4, 7)
;
