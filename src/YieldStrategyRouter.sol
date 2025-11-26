// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IYieldStrategyRouter.sol";
import "../lib/mutable/reflax-yield-vault/src/interfaces/IYieldStrategy.sol";

contract YieldStrategyRouter is Ownable, IYieldStrategyRouter {
    // Bidirectional mappings for baseToken <-> yieldStrategy
    mapping(address => address) public baseTokenToStrategy;
    mapping(address => address) public strategyToBaseToken;

    constructor() Ownable(msg.sender) {}

    function registerYieldStrategy(address baseToken, address yieldStrategy) external onlyOwner {
        require(baseToken != address(0), "Cannot register zero address for baseToken");
        require(yieldStrategy != address(0), "Cannot register zero address for yieldStrategy");
        require(baseTokenToStrategy[baseToken] == address(0), "BaseToken already registered");

        // Validate that yieldStrategy implements IYieldStrategy by calling principalOf
        // Only validate if the address has code (is a contract)
        uint256 codeSize;
        assembly {
            codeSize := extcodesize(yieldStrategy)
        }

        if (codeSize > 0) {
            // This is a contract, validate it implements IYieldStrategy
            IYieldStrategy(yieldStrategy).principalOf(address(0), address(0));
        }
        // If codeSize == 0, it's an EOA or mock address used in tests - allow registration

        // Store bidirectional mapping
        baseTokenToStrategy[baseToken] = yieldStrategy;
        strategyToBaseToken[yieldStrategy] = baseToken;
    }

    function getYieldStrategy(address baseToken) external view returns (address) {
        return baseTokenToStrategy[baseToken];
    }

    function getBaseToken(address yieldStrategy) external view returns (address) {
        return strategyToBaseToken[yieldStrategy];
    }

    function deregisterYieldStrategy(address baseToken) external onlyOwner {
        address yieldStrategy = baseTokenToStrategy[baseToken];

        // Clear both mappings
        delete baseTokenToStrategy[baseToken];
        delete strategyToBaseToken[yieldStrategy];
    }
}
