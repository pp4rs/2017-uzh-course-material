/*
    Partial Solution to Learner Challenge on selecting rows with WHERE,
        and then ordering the result

    Author: @lachlandeer
*/;

SELECT
      AuctionID
    , BidderID
    , Bid
FROM
    bids
WHERE
    BidderID IN(1,4)
    AND
    AuctionID % 2 = 0
ORDER BY
      AuctionID DESC
    , BidderID
;
