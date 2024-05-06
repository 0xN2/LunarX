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
        console.log("Repay...");

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address tokenLunarX = 0x88722fe08849E91eD6dA694B62EFD37885c5dBFd;
        
        address tokenUsdt = 0x94a9D9AC8a22534E3FaCa9F4e7F2E2cf85d5E4C8;
        //OWRNERC20//0x72441784AeAFDb42a26880FE4b6e17370029a16c;
        
        address vestingAddress = 0x994a67837723B5828096295798b1A154E53b15f1;
        address owner = 0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5;

        address dexAddress =  0x318348C7eef9FbF7942Cea767696f6c05a08af41;
        Vesting vestingContract = Vesting(vestingAddress);
        LunarX lunarXContract = LunarX(tokenLunarX);
        UsdT usdTContract = UsdT(tokenUsdt);

        Dex dexContract = Dex(dexAddress);

        vm.startBroadcast(deployerPrivateKey);
       // LunarX Lunar = new LunarX(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5);
       // Old
       //UsdT Usd = new UsdT(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5);
                
       // Vesting vest = new Vesting(tokenLunarX, 2000, payable(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5));
        
       // Dex dex = new Dex(payable(0xd3E7c6032Cb71BAc39C2c16Df41b5364b6158de5), vestingAddress, tokenLunarX);


// last call all together

       vestingContract.setDexAddress(dexAddress);
        lunarXContract.mint(dexAddress, 100e18);
        usdTContract.approve(dexAddress, 100e6);
        
        //usdTContract.mint(owner, 100e6); 

       dexContract.depositUSDTandReciveToken(1e6);

        vm.stopBroadcast();
    }
}
