// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";

contract YieldStrategyRouter is Ownable {
    constructor() Ownable(msg.sender) {}

    function registerYieldStrategy(address baseToken, address yieldStrategy) external onlyOwner {
        // Empty stub - red phase
    }

    function getYieldStrategy(address baseToken) external view returns (address) {
        // Empty stub - red phase
        return address(0);
    }

    function getBaseToken(address yieldStrategy) external view returns (address) {
        // Empty stub - red phase
        return address(0);
    }

    function deregisterYieldStrategy(address baseToken) external onlyOwner {
        // Empty stub - red phase
    }
}
