// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "forge-std/Test.sol";
import "../src/Factory.sol";
import "../src/DexWithApprove.sol";
import "../src/Vesting.sol";

contract LunarXFactoryTest is Test {
    LunarXFactory public factory;
    address public token = address(0x123);
    address public tokenX = address(0x456);
    address public tokenUSDT = address(0x789);
    address public owner = address(this);

    function setUp() public {
        factory = new LunarXFactory();
    }

    function testDeployVesting() public {
        uint256 expiryDuration = 365 days;

        factory.deployVesting(token, expiryDuration, owner);
        
        address[] memory deployedVestingContracts = factory.getVestingDeployedContracts();
        
        assertEq(deployedVestingContracts.length, 1);
        assertEq(deployedVestingContracts[0], address(factory.vestingDeployedContracts(0)));
    }

    function testDeployDex() public {
        uint256 expiryDuration = 365 days;
        factory.deployVesting(token, expiryDuration, owner);

        address vestingAddress = factory.vestingDeployedContracts(0);

        factory.deployDex(owner, vestingAddress, tokenX, tokenUSDT);

        address[] memory deployedDexContracts = factory.getDexDeployedContracts();

        assertEq(deployedDexContracts.length, 1);
        assertEq(deployedDexContracts[0], address(factory.dexDeployedContracts(0)));
    }
}