/*
    Demonstrate how to order the rows of output with ORDERBY

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
ORDER BY
    District ASC
;
