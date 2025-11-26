// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * @title IYieldStrategyRouter
 * @notice Interface for the YieldStrategyRouter registry contract
 * @dev This router serves as a registry that maps underlying tokens to their yield strategies,
 *      similar to how Uniswap's factory contract maps token pairs.
 */
interface IYieldStrategyRouter {
    /**
     * @notice Register a new base token to yield strategy mapping
     * @dev Only callable by the contract owner
     * @param baseToken The underlying token address
     * @param yieldStrategy The yield strategy contract address
     */
    function registerYieldStrategy(address baseToken, address yieldStrategy) external;

    /**
     * @notice Get the registered yield strategy for a base token
     * @param baseToken The underlying token address
     * @return The yield strategy contract address (address(0) if not registered)
     */
    function getYieldStrategy(address baseToken) external view returns (address);

    /**
     * @notice Get the base token for a registered yield strategy
     * @param yieldStrategy The yield strategy contract address
     * @return The underlying token address (address(0) if not registered)
     */
    function getBaseToken(address yieldStrategy) external view returns (address);

    /**
     * @notice Deregister a base token and its associated yield strategy
     * @dev Only callable by the contract owner
     * @param baseToken The underlying token address to deregister
     */
    function deregisterYieldStrategy(address baseToken) external;
}
