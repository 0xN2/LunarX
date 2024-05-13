// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "../src/GaslessTokenTransfer.sol";


 contract  MockToken is ERC20, ERC20Permit {
    constructor() ERC20("MockToken", "MTK") ERC20Permit("MockToken"){
    
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
contract GaslessTokenTransferTest is Test {
    ERC20Permit private token;
    GaslessTokenTransfer private gasless;

    uint256 constant SENDER_PRIVATE_KEY = 111;
    address sender;
    address receiver;
    uint256 constant AMOUNT = 1000;
    uint256 constant FEE = 10;

    function setUp() public {
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(2);

        MockToken token = new MockToken();
        token.mint(sender, AMOUNT);

        gasless = new GaslessTokenTransfer();
    }

    function testValidSig() public {
        uint256 deadline = block.timestamp + 60;

         // Sender - prepare permit signature
        bytes32 permitHash = _getPermitHash(
            sender,
            address(gasless),
            AMOUNT,
            token.nonces(sender),
            deadline
        );
        /*
        (uint8 v, bytes32 r, bytes32 s) =
            vm.sign(SENDER_PRIVATE_KEY, permitHash);

        // Execute transfer
        gasless.send(
            address(token), sender, receiver, AMOUNT, deadline, v, r, s
        );

        // Check balances
        assertEq(token.balanceOf(sender), 0, "sender balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "receiver balance"); */
      
    }

    function _getPermitHash(
        address owner,
        address spender,
        uint256 value,
        uint256 nonce,
        uint256 deadline
    ) private view returns (bytes32) {
        return keccak256(
            abi.encodePacked(
                "\x19\x01",
                token.DOMAIN_SEPARATOR(),
                keccak256(
                    abi.encode(
                        keccak256(
                            "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                        ),
                        owner,
                        spender,
                        value,
                        nonce,
                        deadline
                    )
                )
            )
        );
    }
}