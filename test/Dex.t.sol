// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "ds-test/test.sol";
import "../src/Dex.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "forge-std/Vm.sol";

contract MockToken is ERC20 {
    constructor() ERC20("MockToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }
   
    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
contract MockToken2 is ERC20 {
    constructor() ERC20("MockToken2", "USD") {
        _mint(msg.sender, 1000000 * 10 ** 6);
    }
     function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}


contract DexTest is DSTest {
    Vm vm = Vm(HEVM_ADDRESS);
    Dex dex;
    MockToken tokenX;
    MockToken2 usdt;
    address deployer;
    address user1;

    function setUp() public {
        deployer = address(this);
        user1 = address(0x123);

        
        tokenX = new MockToken();
        usdt = new MockToken2();

        // Mint some initial balances
        usdt.mint(user1, 1000 * 1e6);  // 1000 USDT

        // Deploy the Dex contract
        dex = new Dex(payable(deployer), address(0), address(tokenX));

        // Allow the Dex contract to spend user's USDT
        vm.prank(user1);
        usdt.approve(address(dex), 1000 * 1e6);

        
    }

    function testDepositUSDTandReceiveTokenX() public {
        // Initial USDT balance of user
        //uint256 initialUSDTBalance = usdt.balanceOf(user1);
        
        // User1 deposits 500 USDT
        vm.prank(user1);
        dex.depositUSDTandReciveToken(1);

   
       
    }
}
