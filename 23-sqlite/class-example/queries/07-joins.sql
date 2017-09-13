/*
    Demonstrates how to combine data using INNER JOIN

    Author: @lachlandeer
*/;

SELECT
      auctions.AuctionID  AS AuctionID
    , auctions.Volume     AS Volume
    , auctions.District   AS District
    , bids.bidderID       AS bidderID
    , bids.bid            AS bid
FROM
    auctions
INNER JOIN
    bids
ON
    auctions.AuctionID = bids.AuctionID
;
