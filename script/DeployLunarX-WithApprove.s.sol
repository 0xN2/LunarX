// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {console2 as console} from "forge-std/console2.sol";
import "../src/tokenLunarX.sol";
import "../src/tokenUsdt.sol";
import "../src/Vesting.sol";
import "../src/DexWithApprove.sol";
import {LunarXFactory} from "../src/Factory.sol";

contract RepayScript is Script {
    function run() external {
        console.log("Deploy...");

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address tokenLunarX = 0x88722fe08849E91eD6dA694B62EFD37885c5dBFd;
        address tokenUsdt = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;
        address ownerAddress = 0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5;

        address vestingAddress = 0x0b9165bE4dB05b7d868845bc8e329E05139aE2cc;

        address dexAddress = 0x5230f1C8Ace9ccd3054B071333bDDd40ed836C99;

        Vesting vestingContract = Vesting(vestingAddress);
        LunarX lunarXContract = LunarX(tokenLunarX);
        UsdT usdTContract = UsdT(tokenUsdt);

        Dex dexContract = Dex(dexAddress);

        vm.startBroadcast(deployerPrivateKey);

        // LunarXFactory factory = new LunarXFactory();

        // LunarX Lunar = new LunarX(ownerAddress);

        // UsdT Usd = new UsdT(ownerAddress);

        //Vesting vest = new Vesting(tokenLunarX, 2000, ownerAddress);

        //Dex dex = new Dex(ownerAddress, vestingAddress, tokenLunarX, tokenUsdt);

        /////if owner could calling all together/////
        // the aprove of usdt, need will changed, for permit, take the signature, and after that call the method deposit

        /* vestingContract.setDexAddress(dexAddress);

        lunarXContract.mint(dexAddress, 1000e18);

        usdTContract.approve(dexAddress, 10e6);
        
        dexContract.depositUSDTandReciveToken(10e6); */

        /////finish and withdraw

        //dexContract.withdraw(tokenUsdt);

        //vestingContract.withdraw();

        //vm.stopBroadcast();
    }
}

// generar pk para wallet test
