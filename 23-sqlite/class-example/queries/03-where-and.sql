/*
    Demonstrate how to select rows using WHERE with AND for
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
    (District == 4) AND (Date == '20120604')
;
