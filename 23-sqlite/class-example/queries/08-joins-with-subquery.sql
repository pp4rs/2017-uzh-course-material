/*
    Demonstrates INNER JOINS when need to use subquery to first compute
        a quantity

    Author: @lachlandeer
*/;

SELECT
      bidders.FirstName     AS FirstName
    , bidders.LastName      AS LastName
    , MIN(auctions.Date)    AS FirstBidDate
    , MAX(auctions.Date)    AS LastBidDate

FROM bids

INNER JOIN bidders
    ON bids.BidderID = bidders.BidderID

INNER JOIN
(
    SELECT
          AuctionID
        , DATE(Year || '-' || Month || '-' || Day) AS Date

    FROM
    (
        SELECT
              a.AuctionID
            , SUBSTR(a.Date, 1, 4) AS Year
            , SUBSTR(a.Date, 5, 2) AS Month
            , SUBSTR(a.Date, 7, 2) AS Day

        FROM Auctions a
    )
) auctions
    ON bids.AuctionID = auctions.AuctionID

GROUP BY
      bidders.FirstName
    , bidders.LastName
;
