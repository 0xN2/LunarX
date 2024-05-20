// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Script} from "forge-std/Script.sol";
import {console2 as console} from "forge-std/console2.sol";
import "../src/tokenLunarX.sol";
import "../src/tokenUsdt.sol";
import "../src/Vesting.sol";
import "../src/Dex.sol";

contract RepayScript is Script {
    function run() external {
        console.log("Deploy...");

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        address tokenLunarX = 0xFF5570d4440aA0380D4ceA8F73A6027C3ce702C6;

        address tokenUsdt = 0x3c499c542cEF5E3811e1192ce70d8cC03d5c3359;

        address ownerAddress = 0x2d52CA3A1757275b42599D9dd7EC5afE4a458D76;

        address vestingAddress = 0xf609E9E0A5de65ECc06a00767304545afF59B770; 

        address dexAddress = 0x22DAcCD029c443D1af422f10dabcFB77EB69319f; 

        Vesting vestingContract = Vesting(vestingAddress);
        LunarX lunarXContract = LunarX(tokenLunarX);
        UsdT usdTContract = UsdT(tokenUsdt);

        Dex dexContract = Dex(dexAddress);

        vm.startBroadcast(deployerPrivateKey);

        //LunarX Lunar = new LunarX(ownerAddress);

        // UsdT Usd = new UsdT(ownerAddress);

        //Vesting vest = new Vesting(tokenLunarX, 20000, ownerAddress);

        Dex dex = new Dex(ownerAddress, vestingAddress, tokenLunarX, tokenUsdt);

        /////if owner could calling all together/////
        // the aprove of usdt, need will changed, for permit, take the signature, and after that call the method deposit

        // vestingContract.setDexAddress(dexAddress);

        //lunarXContract.mint(dexAddress, 1000e18);

        //dexContract.depositUSDTandReciveToken(1e6, 1715716583, 27, 0x8972ba328ee5d050e3eb76cba4cc6ebe13f5d43c791116ca603cdb827c4a20ce, 0x7393beb81296338b442a4c2d6338b095bf58727aaec86f4fb515d8786dab4c30);

        /////finish and withdraw

        //dexContract.withdraw(tokenUsdt);

        //vestingContract.withdraw();

        vm.stopBroadcast();
    }
}

// generar pk para wallet test
