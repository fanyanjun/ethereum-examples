pragma solidity ^0.5.0;

import "./oraclizeAPI.sol";

contract YoutubeViews is usingOraclize {

    string public viewsCount;

    event LogYoutubeViewCount(string views);
    event LogNewOraclizeQuery(string description);

    constructor() public {
        update(); // Update views on contract creation...
    }

    function __callback(bytes32 myid, string memory result) public {
        require(msg.sender == oraclize_cbAddress());
        viewsCount = result;
        emit LogYoutubeViewCount(viewsCount);
        // Do something with viewsCount, like tipping the author if viewsCount > X?
    }

    function update() public payable {
        emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer...");
        oraclize_query("URL", 'html(https://www.youtube.com/watch?v=9bZkp7q19f0).xpath(//*[contains(@class, "watch-view-count")]/text())');
    }
}
