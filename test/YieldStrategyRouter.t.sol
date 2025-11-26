// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {YieldStrategyRouter} from "../src/YieldStrategyRouter.sol";

contract YieldStrategyRouterTest is Test {
    YieldStrategyRouter public router;
    address public owner;
    address public nonOwner;
    address public baseToken;
    address public yieldStrategy;

    function setUp() public {
        owner = address(this);
        nonOwner = makeAddr("nonOwner");
        baseToken = makeAddr("baseToken");
        yieldStrategy = makeAddr("yieldStrategy");

        router = new YieldStrategyRouter();
    }

    // Test 1: Test registerYieldStrategy correctly stores mapping
    function test_RegisterYieldStrategy_StoresMapping() public {
        router.registerYieldStrategy(baseToken, yieldStrategy);

        // This should fail because the stub doesn't actually store anything
        address retrievedStrategy = router.getYieldStrategy(baseToken);
        assertEq(retrievedStrategy, yieldStrategy, "Yield strategy should be stored and retrieved");
    }

    // Test 2: Test getYieldStrategy returns correct yield strategy for base token
    function test_GetYieldStrategy_ReturnsCorrectStrategy() public {
        router.registerYieldStrategy(baseToken, yieldStrategy);

        // This should fail because stub returns address(0)
        address retrievedStrategy = router.getYieldStrategy(baseToken);
        assertEq(retrievedStrategy, yieldStrategy, "Should return correct yield strategy");
        assertTrue(retrievedStrategy != address(0), "Should not return zero address for registered token");
    }

    // Test 3: Test getBaseToken returns correct base token for yield strategy
    function test_GetBaseToken_ReturnsCorrectBaseToken() public {
        router.registerYieldStrategy(baseToken, yieldStrategy);

        // This should fail because stub returns address(0)
        address retrievedBaseToken = router.getBaseToken(yieldStrategy);
        assertEq(retrievedBaseToken, baseToken, "Should return correct base token");
        assertTrue(retrievedBaseToken != address(0), "Should not return zero address for registered strategy");
    }

    // Test 4: Test deregisterYieldStrategy resets mappings to zero address
    function test_DeregisterYieldStrategy_ResetsMapping() public {
        // First register
        router.registerYieldStrategy(baseToken, yieldStrategy);

        // Then deregister
        router.deregisterYieldStrategy(baseToken);

        // This might fail if register worked but deregister doesn't clear
        address retrievedStrategy = router.getYieldStrategy(baseToken);
        assertEq(retrievedStrategy, address(0), "Deregistered strategy should return zero address");

        address retrievedBaseToken = router.getBaseToken(yieldStrategy);
        assertEq(retrievedBaseToken, address(0), "Deregistered base token should return zero address");
    }

    // Test 5: Test onlyOwner modifier on registerYieldStrategy
    function test_RegisterYieldStrategy_OnlyOwner() public {
        vm.prank(nonOwner);

        // This should revert due to Ownable modifier - might actually pass
        vm.expectRevert();
        router.registerYieldStrategy(baseToken, yieldStrategy);
    }

    // Test 6: Test onlyOwner modifier on deregisterYieldStrategy
    function test_DeregisterYieldStrategy_OnlyOwner() public {
        // First register as owner
        router.registerYieldStrategy(baseToken, yieldStrategy);

        vm.prank(nonOwner);

        // This should revert due to Ownable modifier - might actually pass
        vm.expectRevert();
        router.deregisterYieldStrategy(baseToken);
    }

    // Test 7: Test cannot register zero address for baseToken
    function test_RegisterYieldStrategy_CannotRegisterZeroBaseToken() public {
        // This should fail because there's no validation in stub
        vm.expectRevert("Cannot register zero address for baseToken");
        router.registerYieldStrategy(address(0), yieldStrategy);
    }

    // Test 8: Test cannot register zero address for yieldStrategy
    function test_RegisterYieldStrategy_CannotRegisterZeroYieldStrategy() public {
        // This should fail because there's no validation in stub
        vm.expectRevert("Cannot register zero address for yieldStrategy");
        router.registerYieldStrategy(baseToken, address(0));
    }

    // Test 9: Test cannot get strategy for unregistered token (returns zero or reverts)
    function test_GetYieldStrategy_UnregisteredToken_ReturnsZero() public {
        address unregisteredToken = makeAddr("unregistered");

        // This might actually pass since stub returns address(0)
        address retrievedStrategy = router.getYieldStrategy(unregisteredToken);
        assertEq(retrievedStrategy, address(0), "Unregistered token should return zero address");
    }

    // Additional test: Verify bidirectional mapping consistency
    function test_BidirectionalMapping_Consistency() public {
        router.registerYieldStrategy(baseToken, yieldStrategy);

        // This should fail because stub doesn't implement reverse mapping
        address retrievedStrategy = router.getYieldStrategy(baseToken);
        address retrievedBaseToken = router.getBaseToken(yieldStrategy);

        assertEq(retrievedStrategy, yieldStrategy, "Forward mapping should work");
        assertEq(retrievedBaseToken, baseToken, "Reverse mapping should work");
    }

    // Additional test: Cannot overwrite existing registration
    function test_RegisterYieldStrategy_CannotOverwriteExisting() public {
        address alternativeStrategy = makeAddr("alternativeStrategy");

        router.registerYieldStrategy(baseToken, yieldStrategy);

        // This should fail because there's no duplicate prevention in stub
        vm.expectRevert("BaseToken already registered");
        router.registerYieldStrategy(baseToken, alternativeStrategy);
    }
}
